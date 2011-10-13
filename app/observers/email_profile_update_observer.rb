class EmailProfileUpdateObserver < ActiveRecord::Observer
  observe :member

  def after_create(member)
    if member.password
      PendingEmail.create! :action => "new_member", :locals => {:password => member.password, :member => member}
    end
  end

  def after_update(member)
    if member.password && member.notify_password_change
      PendingEmail.create! :action => "reset_password", :locals => {:password => member.password, :member => member}
    end
  end

end
