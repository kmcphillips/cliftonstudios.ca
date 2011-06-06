namespace :jobs do

  desc "Send all pending emails"
  task :deliver_email => :environment do
    while message = PendingEmail.next!
      puts "Delivering #{message.action} to #{message.locals[:member].try(:name) || "everyone"}"
      message.deliver
    end
  end
end
