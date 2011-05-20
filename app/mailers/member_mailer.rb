class MemberMailer < ActionMailer::Base
  default :from => "robot@cliftonstudios.ca"

  def reset_password(member, opts)
    @member = member
    @password = opts[:password]
    mail(:to => "#{member.name} <#{member.email}>", :subject => "Clifton Studios: Password reset")
  end

end

