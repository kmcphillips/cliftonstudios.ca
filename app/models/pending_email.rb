class PendingEmail < ActiveRecord::Base
  TYPES = %w[new_member new_event new_post contact_executive new_minutes]

  serialize :locals, Hash

  belongs_to :member

  validates :action, :inclusion => TYPES

  scope :pending, where(:processing => false)
  
  def deliver!
    # TODO: This should rescue errors and have a state more than just true/false
    MemberMailer.send(action, locals).deliver
  end

  def recipients_description
    case action
      when "new_event", "new_post"
        "Everyone"
      when "new_member"
        locals[:member].try(:name)
      when "contact_executive"
        "The Executive"
      else
        "Unknown"
    end
  end

  ## Class methods

  def self.next!
    if message = where(:processing => false).order("created_at ASC").first
      message.update_attribute :processing, true
      message
    end
  end

  def self.create_executive_message!(subject, body, from, anonymous=nil)
    create! :action => "contact_executive", :locals => {:subject => subject, :body => body, :from => from, :anonymous => anonymous}
  end

end

