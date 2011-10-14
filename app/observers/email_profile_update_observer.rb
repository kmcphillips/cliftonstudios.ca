class EmailProfileUpdateObserver < ActiveRecord::Observer
  observe :member

  def after_create(member)
    if member.password
      PendingEmail.create! :action => "new_member", :locals => {:password => member.password, :member => member}
    end
  end

end
