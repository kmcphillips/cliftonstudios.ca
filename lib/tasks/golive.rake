desc "Reset everyone's passwords and email them out'"
task :reset_all_passwords => :environment do

  Member.active.alphabetical.each do |member|
    begin
      puts "Processing #{member.name} (#{member.email})"

      if member.id == 2 || member.id == 36
        password = "(No Change)"
      else
        password = member.change_password!
      end

      MemberMailer.first_login(:id => member.id, :password => password).deliver

      puts "   Done"
    rescue => e
      puts "   ERROR: #{e}"
    end
  end

  puts "\nDone"
end
