desc "Go Live. Destroy all tables and data. Import all."
task :golive => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed"].invoke
  Rake::Task["import:clear:images"].invoke
  Rake::Task["import:all"].invoke
end

desc "Reset everyone's passwords and email them out'"
task :reset_all_passwords => :environment do

  Member.active.alphabetical.each do |member|
    puts "Processing #{member.name} (#{member.email})"
    password = member.reset_password!
    MemberMailer.reset_password(:member => member, :password => password).deliver
  end

  puts "\nDone"
end
