if Rails.env.development?
  puts "Creating test@test.com / test member"
  Member.create!(:email => 'test@test.com', :password => 'test', :password_confirmation => 'test')
  
end
