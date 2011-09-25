class Member < ActiveRecord::Base

  CONTACT_METHODS = %w[email phone]

  acts_as_authentic do |config|
    config.logged_in_timeout = 1.day
    config.merge_validates_length_of_password_field_options :within => PASSWORD_MIN_LENGTH..20
  end

  acts_as_permalink :from => :name
  
  include AttachedImage
  
  has_many :posts
  has_many :events
  has_many :pictures
  has_many :titles, :class_name => "Executive", :foreign_key => "member_id"
  
  validates :name, :presence => true
  validates :contact_method, :inclusion => CONTACT_METHODS
  validate :website_begins_with_protocol

  before_validation :set_default_password
  before_save :create_secret_hash

  attr_accessor :notify_password_change

  scope :alphabetical, order("name ASC")
  scope :sorted, alphabetical
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)
  scope :emailable, where(:receive_emails => true, :active => true)

  def reset_password!
    change_password

    if save
      password
    else
      self.notify_password_change = nil
    end
  end

  def profile_configured?
    !%w[email phone address name].map(&:blank?).any?
  end

  def to_csv
    [name, address, phone, email]
  end

  def email_with_name
    "#{name} <#{email}>" unless email.blank?
  end

  def last_name
    name.split(" ").last
  end

  def phone_numbers
    [phone, alternate_phone].reject(&:blank?).join(" or ")
  end

  def website_with_protocol
    if website.present? && website != "http://"
      if website =~ /^http/
        website
      else
        "http://#{website}"
      end
    end
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

  def self.for_artists_index
    active.sort{|a, b| a.last_name <=> b.last_name }
  end

  protected

  def change_password
    password = MemorablePassword.generate :min_length => PASSWORD_MIN_LENGTH

    self.password = password
    self.password_confirmation = password
    self.password_configured = false
    self.notify_password_change = true
  end

  ## Callbacks and validations

  def website_begins_with_protocol
    errors.add(:website, "must begin with 'http://' or 'https://'") unless website =~ /http(s)?:\/\/.+/ || website.blank? || website == "http://"
  end

  def set_default_password
    if new_record? && password.blank? && password_confirmation.blank?
      self.notify_password_change = nil
      change_password
    end
    true
  end

  def create_secret_hash
    self.secret_hash = Digest::SHA1.hexdigest(rand.to_s) if self.secret_hash.blank?
    true
  end

end
