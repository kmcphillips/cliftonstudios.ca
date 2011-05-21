class PendingEmail < ActiveRecord::Base
  serialize :locals, Hash

  belongs_to :member

  validates :method, :presence => true

  def deliver!
    MemberMailer.send(method, locals).deliver
  end

  ## Class methods

  def self.next!
    if message = where(:processing => false).order("created_at ASC").first
      message.update_attribute :processing, true
      message
    end
  end

end

