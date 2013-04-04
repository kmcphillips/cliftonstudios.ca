namespace :jobs do

  desc "Send all pending emails"
  task :deliver_email => :environment do
    pending = PendingEmail.processing.last
    if pending
      if pending.created_at < (Time.now - 2.hours)
        puts "Job has been runing an abnormally long time."
        ErrorMailer.pending_email.deliver
        pending.update_attribute :status, "failed"
      else
        puts "Aborting since there is still a message in processing."
      end

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
