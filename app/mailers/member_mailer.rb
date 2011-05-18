class MemberMailer < ActionMailer::Base
  default :from => "robot@cliftonstudios.ca"

  def reset_password(member, password)
    @member = member
    @password = password
    mail(:to => "#{member.name} <#{member.email}>", :subject => "Clifton Studios: Password reset")
  end

end

