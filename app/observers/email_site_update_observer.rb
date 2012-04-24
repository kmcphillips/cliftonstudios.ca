class EmailSiteUpdateObserver < ActiveRecord::Observer
  observe :post, :event, :minutes

  def after_create(object)
    case object
      when Post, Event
        PendingEmail.create! :action => "new_#{object.class.to_s.downcase}", :locals => {:id => object.id}
      when Minutes
        PendingEmail.create! :action => "new_minutes"
    end

    true
  end

end

