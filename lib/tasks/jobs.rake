namespace :jobs do

  desc "Send all pending emails"
  task :deliver_email => :environment do
    while message = PendingEmail.next!
      puts "Delivering #{message.method} to #{message.everyone? ? "everyone" : message.locals[:member].try(:name) || "unknown"}"
      message.deliver
    end
  end
end
