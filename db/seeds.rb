if Rails.env.development?
  puts "Creating test/test member"
  Member.new(:email => 'test', :password => 'test', :password_confirmation => 'test', :name => "Test User").save!(false)
end
