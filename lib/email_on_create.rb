module EmailOnCreate

  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do

      after_create :create_email

    end
  end

  module ClassMethods
  end

  protected

  def create_email
    case self
      when Post, Event
        PendingEmail.create! :action => "new_#{self.class.to_s.downcase}", :locals => {:id => self.id}
      when Minutes
        PendingEmail.create! :action => "new_minutes"
    end

    true
  end

end
