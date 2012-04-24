class MemberMailer < ActionMailer::Base
  default :from => ROBOT_EMAIL

  def first_login(opts)
    @member = Member.find(opts[:id])
    @password = opts[:password]

    mail(:to => "#{@member.name} <#{@member.email}>", :subject => "Clifton Studios: Important Password Correction")
  end

  def forgot_password(opts)
    @member = Member.find(opts[:id])

    mail(:to => "#{@member.name} <#{@member.email}>", :subject => "Clifton Studios: Forgotten Password")
  end

  def new_member(opts)
    @member = Member.find(opts[:id])
    @password = opts[:password]

    mail(:to => "#{@member.name} <#{@member.email}>", :subject => "Welcome to Clifton Studios")
  end

  def new_post(opts)
    @post = Post.find(opts[:id])

    mail(:to => ROBOT_EMAIL, :bcc => everyone, :subject => "Clifton Studios News Post: #{@post.title}")
  end

  def new_event(opts)
    @event = Event.find(opts[:id])

    mail(:to => ROBOT_EMAIL, :bcc => everyone, :subject => "Clifton Studios Event: #{@event.title}")
  end

  def new_minutes(opts)
    mail(:to => ROBOT_EMAIL, :bcc => everyone, :subject => "Clifton Studios Meeting Minutes Added")
  end

  def contact_executive(opts)
    @message = opts[:body]
    @view_from = opts[:anonymous] ? "anonymous@cliftonstudios.ca" : opts[:from]
    @view_subject = opts[:subject]

    mail(:to => executive, :bcc => admin, :subject => "Website Message: #{opts[:subject]}", :from => opts[:from] || ROBOT_EMAIL)
  end

  def delivery_error(exception)
    @message = exception.message

    mail(:to => admin, :subject => "Clifton Studios Mail Delivery Error")
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
