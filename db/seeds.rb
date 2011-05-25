if Rails.env.development?
  email = 'test@test.test'
  if member = Member.find_by_email(email)
    puts "Deleting old test member"
    member.destroy
  end
  puts "Creating test/test member"
  Member.new(:email => email, :password => 'test', :password_confirmation => 'test', :name => "Test User").save!
end

puts "Creating 'About' block"
b = Block.new
b.label = "about"
b.path = "/about"
b.description = "The top of the About page, containing the history of the studio, what we are, and other such broad information."
b.accepts_image = true
b.save!

puts "Creating 'Members' block"
b = Block.new
b.label = "members"
b.path = "/members"
b.description = "This text will appear at the top of the members page, describing what our members are entitled to and what they do."
b.save!

puts "Creating 'Availablity' block"
b = Block.new
b.label = "availability"
b.path = "/about"
b.description = "This section describes studio space availability and how to contact someone about becoming a member."
b.save!
