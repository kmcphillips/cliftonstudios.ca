desc "Reset everyone's passwords and email them out'"
task :reset_all_passwords => :environment do

  #Member.active.alphabetical.each do |member|
  [Member.find_by_id(36)].each do |member|
    begin
      puts "Processing #{member.name} (#{member.email})"

      if member.id == 2
        password = "(No Change)"
      else
        password = member.change_password!
      end

      MemberMailer.first_login(:member => member, :password => password).deliver

      puts "   Done"
    rescue => e
      puts "   ERROR: #{e}"
    end
  end

  puts "\nDone"
end
