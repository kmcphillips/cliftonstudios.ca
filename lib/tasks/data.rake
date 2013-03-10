namespace :data do

  desc "Format all phone numbers"
  task :format_phone_numbers => :environment do
    STDOUT.sync = true

    ActiveRecord::Base.transaction do
      Member.all.each do |member|
        puts member.name

        [:phone, :alternate_phone].each do |field|
          if member.send(field).present?
            member.send("#{field}=", "204#{member.send(field)}") if member.send(field).length < 9
          end
        end

        begin
          member.save!
        rescue => e
          puts "Error on: #{member.inspect}"
          raise e
        end

        puts "    phone:           #{member.phone}"
        puts "    alternate_phone: #{member.alternate_phone}"

      end
    end
  end
end
