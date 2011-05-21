class Member < ActiveRecord::Base
  
  acts_as_authentic do |config|
    config.logged_in_timeout = 1.day
  end

  acts_as_permalink :from => :name
  
  include AttachedImage
  
  has_many :posts
  has_many :pictures
  
  validates :name, :presence => {:message => "is required"}
  validates :email, :presence => {:message => "is required"}

  scope :alphabetical, order("name ASC")
  scope :active, where(:active => true)
  scope :emailable, where(:receive_emails => true, :active => true)

  def reset_password!
    password = MemorablePassword.generate

    self.password = password
    self.password_confirmation = password
    self.password_configured = false

    if save
      password
    end
  end

  def profile_configured?
    !%w[email phone address name].map(&:blank?).any?
  end

  def to_csv
    [name, address, phone, email]
  end

  ## Class methods

  def self.contact_list_csv
    FasterCSV.generate do |csv|
      csv << ["Clifton Studios Contact List"]
      csv << ["Generated: #{Time.now.to_s(:with_time)}"]
      csv <<
      csv << %w[name address phone email]
      Member.active.alphabetical.each do |member|
        csv << member.to_csv
      end
    end
  end
end
