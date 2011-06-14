class Importer
  include ActionView::Helpers::SanitizeHelper

  if Rails.env.development?  
    IMAGE_PATH = "/home/kevin/gleep/cliftonstudios.ca/html/pictures/"
  else
    IMAGE_PATH = "/home/kevin/cliftonstudios.ca/html/pictures/"
  end
  
  def initialize(config)
    keys = %w(host username password database)
    raise "Invalid params. Requires: #{keys.join(", ")}." unless keys.inject(true){|acc,key| acc && config[key]}
    
    puts "Connecting to database '#{config["database"]}' with user '#{config["username"]}'..."
    @db = Mysql2::Client.new(
        :host => config["host"], 
        :username => config["username"], 
        :password => config["password"], 
        :database => config["database"]
    )
    puts "Connected"
  end
  
  def import!
    begin
      ActiveRecord::Base.transaction do
        clear_tables
        import_members
        import_posts
        import_about
        import_images
        # import_events  # Not going to import events since everything will be past

        puts "Destroying all pending emails created by import"
        PendingEmail.destroy_all
        puts ""

        puts "Success!"

      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end
  
  protected
 
  def clear_tables
    puts "Deleting image files for pictures"
    Picture.all.each do |p|
      p.destroy
    end

    tables = %w(posts members pictures)    
    puts "Truncating tables: #{tables.join(", ")}"

    tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table}")
    end
  end

  def import_members
    puts "Importing members..."
    @db.query("SELECT m.id, m.full_name, b.description, m.email_notification, m.email, m.picture, m.type FROM user AS m LEFT JOIN bio as b ON m.id = b.user WHERE m.id != 1 ORDER BY m.id ASC").each do |result|
      message = ""

      member = Member.new(:name => result["full_name"], :bio => result["description"], :receive_emails => true, :email => result["email"], :legacy_username => result["username"], :legacy_name => result["full_name"].downcase.gsub(/[^A-Za-z0-9]/, "+"))
      member.id = result["id"]

      if member.name == "Kevin McPhillips" && Rails.env.development?
        member.password = member.password_confirmation = DEV_PASSWORD
        member.email = DEV_USERNAME
        message = "with dev mode credentials"
      end

      case result["type"]
        when "ADMIN"
          member.active = true
          member.admin = true
        when "MEMBER"
          member.active = true
          member.admin = false
        when "INACTIVE"
          member.active = false
          member.admin = false
      end

      if result["picture"].present?
        member.image = File.open("#{IMAGE_PATH}/p#{result["picture"]}.jpg")
      end

      if member.save
        puts "  Member ##{member.id} (#{member.name}) created #{message}"
      else
        puts "  ERROR: Could not save member #{member.name}: #{member.errors.full_messages.to_sentence}"
      end
    end

    puts "Done"
    puts ""
  end

  def import_posts
    puts "Importing news posts..."
    @db.query("SELECT * FROM news WHERE members_only = 0 ORDER BY id ASC").each do |result|
      # no news posts have images so we get off easy by not having to import those
      post = Post.new(:title => result["post_title"], :member_id => result["post_by"], :body => result["post"], :updated_at => result["post_date"], :created_at => result["post_date"])
      post.save!
      puts "  Post ##{post.id} created"
    end
    puts "Done"
    puts ""
  end

  def import_about
    puts "Importing about..."
    b = Block.find_by_label!("about")
    b.body = @db.query("SELECT * FROM about WHERE title NOT LIKE '%How to Join%' ORDER BY sort_order ASC").map{|r| r["description"] }.join("\n\n")
    b.save!
    puts "  Loaded 'about' block"

    b = Block.find_by_label!("availability")
    b.body = @db.query("SELECT * FROM about WHERE title LIKE '%How to Join%' LIMIT 1").first["description"]
    b.save!
    puts "  Loaded 'availability' block"
    
    puts "Done"
    puts ""
  end

  def import_images
    puts "Importing pictures..."
    @db.query("SELECT * FROM picture").each do |result|
      description = result["description"].blank? ? result["title"] : "#{result["title"]} #{result["description"]}"

      p = Picture.new :description => description, :member_id => result["post_by"]
      p.image = File.open("#{IMAGE_PATH}/p#{result["picture"]}.#{result["type"]}")

      if p.save
        p.update_attribute :created_at, result["post_dat"]
        puts "  Imported picture ##{result["id"]} as Picture ##{p.id}"
      else
        puts "  ERROR importing picture ##{result["id"]}"
      end
    end

    puts "Done"
    puts ""
  end

end
