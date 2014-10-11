class PendingEmail < ActiveRecord::Base
  TYPES = %w[new_member new_event new_post contact_executive new_minutes bylaw]
  STATUSES = %w[pending processing complete failed]

  serialize :locals, Hash

  belongs_to :member

  validates :action, :inclusion => TYPES
  validates :status, :inclusion => STATUSES

  scope :pending, ->{ where(status: "pending") }
  scope :processing, ->{ where(status: "processing") }
  scope :failed, ->{ where(status: "failed") }
  scope :incomplete, ->{ where("status != 'complete'") }

  def deliver!
    MemberMailer.send(action, locals).deliver
    update_attribute :status, "complete"
  end

  def recipients_description
    case action
      when "new_event", "new_post", "new_minutes", "bylaw"
        "Everyone"
      when "new_member"
        Member.find_by_id(locals[:id]).try(:name)
      when "contact_executive"
        "The Executive"
      else
        "Unknown"
    end
  end

  ## Class methods

  def self.next!
    if message = pending.order("created_at ASC").first
      message.update_attribute :status, "processing"
      message
    end
  end

  def self.create_executive_message!(subject, body, from, anonymous=nil)
    create! :action => "contact_executive", :locals => {:subject => subject, :body => body, :from => from, :anonymous => anonymous}
  end

end

