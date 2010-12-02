class Importer
  include ActionView::Helpers::SanitizeHelper
  
  def initialize(config)
    keys = %w(host username password schema)
    raise "Invalid params. Requires: #{keys.join(", ")}." unless keys.inject(true){|acc,key| acc && config[key]}
    
    puts "Connecting to database '#{config["schema"]}' with user '#{config["username"]}'..."
    @db = Mysql2::Client.new(
        :host => config["host"], 
        :username => config["username"], 
        :password => config["password"], 
        :database => config["schema"]
    )
    puts "Connected"
  end
  
  def import!
    begin
      ActiveRecord::Base.transaction do
        clear_tables
        import_members
        import_posts
        
      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end
  
  protected
 
  def clear_tables
    tables = %w(posts members)    
    puts "Truncating tables: #{tables.join(", ")}"

    tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table}")
    end
  end

  def import_members
    puts "Importing members..."
    @db.query("SELECT * FROM members AS m LEFT JOIN bio as b ON m.id = b.user WHERE m.id != 1 ORDER BY m.id ASC").each do |result|
      member = Member.new(:id => result["id"], :visible => result["visible"], :name => result["full_name"], :bio => result["description"], :receive_emails => result["email_notification"], :email => result["email"], :password => result["email"], :password_confirmation => result["email"])
      member.status = case result["type"]
        when "ADMIN" then "admin"
        when "MEMBER" then "active"
        when "INACTIVE" then "inactive"
      end
      
      # TODO: import images
      
      member.save!
      puts "  Member ##{member.id} (#{member.name}) created"
    end
    puts "Done"
  end

  def import_posts
    puts "Importing news posts..."
    @db.query("SELECT * FROM news ORDER BY id ASC").each do |result|
      # no news posts have images so we get off easy by not having to import those
      post = Post.new(:title => result["post_title"], :member_id => result["post_by"], :body => result["post"], :members_only => result["members_only"], :status => "sent", :updated_at => result["post_date"], :created_at => result["post_date"])
      post.save!
      puts "  Post ##{post.id} created"
    end
    puts "Done"
  end

  # def import_about
  #   puts "Importing about..."
  #   b = Block.find_by_label!("bio")
  #   result = @db.query("SELECT * FROM bio").first
  #   
  #   b.body = result["body"]
  #   b.save!
  #   puts "Done"
  # end

end
