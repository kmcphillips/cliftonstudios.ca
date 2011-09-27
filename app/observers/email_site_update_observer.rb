class EmailSiteUpdateObserver < ActiveRecord::Observer
  observe :post, :event

  def after_create(object)
    case object
      when Post, Event
        PendingEmail.create! :action => "new_#{object.class.to_s.downcase}", :locals => {:object => object}

    end
  end

end
