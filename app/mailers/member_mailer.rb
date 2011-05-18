class MemberMailer < ActionMailer::Base
  default :from => ""

  def reset_password(member, password)
    @user = user
    @password = password
    mail(:to => "#{member.name} <#{member.email}>", :subject => "")
  end

end

