class EmailSiteUpdateObserver < ActiveRecord::Observer
  observe :post, :event

  def after_create(object)

  end

end

