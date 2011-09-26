class MemberMailer < ActionMailer::Base
  default :from => ROBOT_EMAIL

  def reset_password(opts)
    @member = opts[:member]
    @password = opts[:password]

    mail(:to => "#{@member.name} <#{@member.email}>", :subject => "Clifton Studios: Password reset")
  end

  def new_post(opts)
    @post = opts[:object]

    mail(:to => ROBOT_EMAIL, :bcc => everyone, :subject => "Clifton Studios News Post: #{@post.title}")
  end

  def new_event(opts)
    @event = opts[:object]

    mail(:to => ROBOT_EMAIL, :bcc => everyone, :subject => "Clifton Studios Event: #{@event.title}")
  end

  def contact_executive(opts)
    @message = opts[:message]

    mail(:to => executive, :bcc => admin, :subject => "Website Message: #{opts[:subject]}", :from => opts[:from] || ROBOT_EMAIL)
  end

  protected

  def everyone
    Member.active.emailable.alphabetical.map(&:email_with_name).compact
  end

  def executive
    Executive.emails.any? ? Executive.emails : admin
  end

  def admin
    ADMIN_EMAIL
  end

end
