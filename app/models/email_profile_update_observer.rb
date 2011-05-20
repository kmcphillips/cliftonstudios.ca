class EmailProfileUpdateObserver < ActiveRecord::Observer
  observe :member

  def after_save(member)
    if member.password
      PendingEmail.create! :mailer => "MemberMailer", :method => :reset_password, :member => member, :locals => {:password => member.password}
    end
  end

end

