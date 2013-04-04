class ErrorMailer < ActionMailer::Base
  default :from => ROBOT_EMAIL

  def pending_email()
    mail(:to => ADMIN_EMAIL, :subject => "Clifton Studios: Pending mail error")
  end

end
