# Seed are destructive. Be careful.
raise "Remove this raise to run in production mode" if Rails.env.production?


puts "Truncating blocks"
ActiveRecord::Base.connection.execute("truncate blocks")

puts "Creating 'About' block"
b = Block.new
b.label = "about"
b.path = "/about"
b.description = "The top of the About page, containing the history of the studio, what we are, and other such broad information."
b.accepts_image = true
b.save!

puts "Creating 'Availablity' block"
b = Block.new
b.label = "availability"
b.path = "/about"
b.description = "This section describes studio space availability and how to contact someone about becoming a member."
b.save!


puts "Truncating executive"
ActiveRecord::Base.connection.execute("truncate executives")

puts "Creating executive positions"
Executive::TITLES.each_with_index do |title, index|
  Executive.create! :title => title, :sort_order => index
end
