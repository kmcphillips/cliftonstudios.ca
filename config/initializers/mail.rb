if File.exists?("#{Rails.root}/config/mail.yml")
  require 'tlsmail'
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

  config = YAML.load_file("#{Rails.root}/config/mail.yml")[Rails.env]

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.smtp_settings = config["smtp_settings"].symbolize_keys || {}
  ActionMailer::Base.default_url_options[:host] = config["host"]

  (config["register_interceptors"] || []).each do |i|
    ActionMailer::Base.register_interceptor i
  end

  BypassMailInterceptor.email = config["bypass"] unless config["bypass"].blank?

else
  Rails.logger.error "Could not find mail.yml. Email disabled."
end
