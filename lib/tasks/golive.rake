desc "Go Live. Destroy all tables and data. Import all."
task :golive => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed"].invoke
  Rake::Task["import:clear:images"].invoke
  Rake::Task["import:all"].invoke
end
