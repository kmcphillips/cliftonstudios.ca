namespace :jobs do

  desc "Send all pending emails"
  task :deliver_email => :environment do
    if PendingEmail.processing.any?
      puts "Aborting since there is still a message in processing."

    else
      begin
        while message = PendingEmail.next!
          puts "Delivering #{message.action} to #{message.recipients_description}"
          message.deliver!
        end
      rescue => e
        MemberMailer.delivery_error e
      end
    end
  end
end
