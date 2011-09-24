class MailingListEntry < ActiveRecord::Base

  validates :email, :presence => true

  scope :active, where(:active => true)
  scope :by_ip, lambda{|ip| where("ip_address LIKE ?", ip)}
  scope :for_index, active.order("created_at DESC")

  def deactivate!
    update_attribute(:active, false)
  end

  ## class methods

  def self.deactivate_email!(e)
    where("email LIKE ?", e.try(:squish)).map do |o|
      o.deactivate!
    end.size
  end

end
