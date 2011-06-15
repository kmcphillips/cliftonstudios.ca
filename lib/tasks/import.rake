namespace :import do

  desc "Import all data from legacy PHP site"
  task :all => :environment do
    config = File.open("#{Rails.root}/config/database.yml", "r") do |f|
      YAML::load(f).try(:[], "legacy")
    end
    raise "Key 'legacy' was not found in config/database.yml" unless config

    Importer.new(config).import!

  end

  namespace :clear do

    desc "Truncate all tables"
    task :tables => :environment do
      unless Rails.env.production?
        %w[blocks events executives links members pending_emails pictures posts].each do |table|
          puts "Truncating '#{table}'"
          ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
        end

        puts "Setting autoincrement for pictures"
        ActiveRecord::Base.connection.execute("ALTER TABLE pictures AUTO_INCREMENT = 65536")
      end
    end

    desc "Delete picture assets"
    task :images => :environment do
      unless Rails.env.production?
        puts "Deleting everying in public/assets/images"
        FileUtils.rm_rf "#{Rails.root}/public/assets/images/"
      end
    end

    desc "Delete images and truncate tables"
    task :all => [:environment, :tables, :images] do
      puts "Done"
    end

  end
end
