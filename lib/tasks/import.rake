namespace :import do

  desc "Import all data from legacy PHP site"
  task :all => :environment do
    config = File.open("#{Rails.root}/config/database.yml", "r") do |f|
      YAML::load(f).try(:[], "legacy")
    end
    raise "Key 'legacy' was not found in config/database.yml" unless config

    Importer.new(config).import!

  end
end

