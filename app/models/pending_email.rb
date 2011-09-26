class PendingEmail < ActiveRecord::Base
  TYPES = %w[new_event new_post reset_password contact_executive]

  serialize :locals, Hash

  belongs_to :member

  validates :action, :inclusion => TYPES

  scope :pending, where(:processing => false)
  
  def deliver!
    MemberMailer.send(action, locals).deliver
  end

  def recipients_description
    case action
      when "new_event", "new_post"
        "Everyone"
      when "reset_password"
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

  def self.create_executive_message!(subject, body, from=nil)
    create! :action => "contact_executive", :locals => {:subject => subject, :body => body, :from => from}
  end

end

