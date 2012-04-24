class EmailProfileUpdateObserver < ActiveRecord::Observer
  observe :member

  def after_create(member)
    if member.password
      PendingEmail.create! :action => "new_member", :locals => {:password => member.password, :id => member.id}
    end
  end

end
