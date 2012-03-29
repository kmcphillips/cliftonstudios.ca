namespace :jobs do

  desc "Send all pending emails"
  task :deliver_email => :environment do
    while message = PendingEmail.next!
      if message.locals[:member].try(:name)
        puts "Delivering #{message.action} to #{message.locals[:member].name}"
      elsif message.action == "contact_executive"
        puts "Delivering #{message.action} to executive"
      else
        puts "Delivering #{message.action} to everyone"
      end
      
      message.deliver!
    end
  end
end
