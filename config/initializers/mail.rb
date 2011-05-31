if File.exists?("#{Rails.root}/config/mail.yml") && !Rails.env.test?
  file = YAML.load_file("#{Rails.root}/config/mail.yml")
  config = file[Rails.env] if file

  if config
    require 'tlsmail'
    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.smtp_settings = config["smtp_settings"].symbolize_keys || {}
    ActionMailer::Base.default_url_options[:host] = config["host"]

    (config["register_interceptors"] || []).each do |i|
      ActionMailer::Base.register_interceptor i
    end

    BypassMailInterceptor.email = config["bypass"] unless config["bypass"].blank?

  else
    Rails.logger.error "Could not find config for environment '#{Rails.env}' in mail.yml. Email disabled."
  end
else
  Rails.logger.error "Could not find mail.yml. Email disabled."
end
