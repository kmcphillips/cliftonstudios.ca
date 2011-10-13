class BypassMailInterceptor
  
  class << self; attr_accessor :email end
  @email = nil
  
  def self.delivering_email(message)
    raise "Bypass email address is not set" unless @email

    addresses = "to:#{message.to}"
    addresses << " cc:#{message.cc}" unless message.cc.blank?
    addresses << " bcc:#{message.bcc}" unless message.bcc.blank?

    message.subject = "[#{addresses}] #{message.subject}"
    message.to = @email
    message.cc = ""
    message.bcc = ""
  end
end

