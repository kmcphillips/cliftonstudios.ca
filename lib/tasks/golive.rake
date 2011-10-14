desc "Reset everyone's passwords and email them out'"
task :reset_all_passwords => :environment do

  Member.active.alphabetical.each do |member|
    begin
      puts "Processing #{member.name} (#{member.email})"

      password = member.change_password!
      MemberMailer.first_login(:member => member, :password => password).deliver

      puts "   Done"
    rescue => e
      puts "   ERROR: #{e}"
    end
  end

  puts "\nDone"
end
