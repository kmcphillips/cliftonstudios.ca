ActionMailer::Base.smtp_settings = {
  :address => "localhost"
}

# TODO: move this out to the env files
if Rails.env.development?
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end

## Gmail
#ActionMailer::Base.smtp_settings = {
#  :address => "smtp.gmail.com",
#  :port => 587,
#  :domain => "cliftonstudios.ca",
#  :authentication => :plain,
#  :enable_starttls_auto => true,
#  :user_name => "kevin.mcphillips",
#  :password => ""
#}
