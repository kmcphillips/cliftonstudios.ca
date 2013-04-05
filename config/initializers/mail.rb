if File.exists?("#{Rails.root}/config/mail.yml") && !Rails.env.test?
  file = YAML.load_file("#{Rails.root}/config/mail.yml")
  config = file[Rails.env] if file

  if config
    if Rails.env.production?
      ActionMailer::Base.smtp_settings = config["smtp_settings"].symbolize_keys || {}
    end

  else
    Rails.logger.error "Could not find config for environment '#{Rails.env}' in mail.yml. Email disabled."
  end
else
  Rails.logger.error "Could not find mail.yml. Email disabled."
end
