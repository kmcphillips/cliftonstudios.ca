class EmailSiteUpdateObserver < ActiveRecord::Observer
  observe :post, :event

  def after_create(object)
    case object
      when Post, Event
        PendingEmail.create! :method => "new_#{object.class.to_s.downcase}".to_sym, :everyone => true, :locals => {:object => object}

    end
  end

end

