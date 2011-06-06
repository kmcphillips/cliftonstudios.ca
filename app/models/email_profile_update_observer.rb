class EmailProfileUpdateObserver < ActiveRecord::Observer
  observe :member

  def after_save(member)
    if member.password && member.notify_password_change
      PendingEmail.create! :action => :reset_password, :locals => {:password => member.password, :member => member}
    end
  end

end
