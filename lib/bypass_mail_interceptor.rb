class BypassMailInterceptor
  
  class << self; attr_accessor :email end
  @email = nil
  
  def self.delivering_email(message)
    raise "Bypass email address is not set" unless @email
    
    message.subject = "[#{message.to}] #{message.subject}"
    message.to = @email
  end
end

