class MailingListEntry < ActiveRecord::Base

  validates :email, :presence => true

  scope :active, -> { where(:active => true) }
  scope :search, ->(search){ where("email like ?", "%#{search}%") }
  scope :by_ip, ->(ip){ where("ip_address LIKE ?", ip) }

  def deactivate!
    update_attribute(:active, false)
  end

  ## class methods

  def self.deactivate_email!(e)
    where("email LIKE ?", e.try(:squish)).map do |o|
      o.deactivate!
    end.size
  end

  def self.bulk_create(data)
    data.downcase.split(/[\s,]/).reject{|x| x.blank? }.map do |email|
      unless find_by_email(email)
        MailingListEntry.create(:email => email)
      end
    end.compact.size
  end

end
