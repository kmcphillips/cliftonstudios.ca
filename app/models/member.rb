class Member < ActiveRecord::Base

  CONTACT_METHODS = %w[email phone]

  acts_as_authentic do |config|
    config.logged_in_timeout = 1.day
    config.merge_validates_length_of_password_field_options :within => PASSWORD_MIN_LENGTH..20
  end

  acts_as_permalink :from => :name
  
  include AttachedImage

  belongs_to :subletting_member, :class_name => "Member", :foreign_key => "subletting_member_id"

  has_many :posts
  has_many :events
  has_many :pictures
  has_many :minutes
  has_many :titles, :class_name => "Executive", :foreign_key => "member_id"
  has_many :dependent_members, :class_name => "Member", :foreign_key => "subletting_member_id"
  
  validates :name, :presence => true
  validates :contact_method, :inclusion => CONTACT_METHODS
  validates :renting, :inclusion => [true, false]
  validate :member_since_format
  validate :website_begins_with_protocol
  validate :subletting_and_associated

  before_validation :set_default_password
  before_save :create_secret_hash
  before_create :set_member_since

  scope :alphabetical, order("name ASC")
  scope :sorted, alphabetical
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)
  scope :emailable, where(:receive_emails => true, :active => true)
  scope :contact_by_phone, where(:contact_method => "phone")

  def deliver_forgotten_password!
    reset_perishable_token!
    MemberMailer.forgot_password(:member => self).deliver
  end

  def profile_configured?
    !%w[email phone address name].map(&:blank?).any?
  end

  def to_csv
    [name, address, phone, alternate_phone, email]
  end

  def email_with_name
    "#{name} <#{email}>" unless email.blank?
  end

  def last_name
    name.split(" ").last
  end

  def phone_numbers
    [phone, alternate_phone].reject(&:blank?)
  end

  def phone_numbers_formatted
    phone_numbers.join(" or ")
  end

  def member_since
    [member_since_month, member_since_year].join(" ")
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

  def website?
    website.present? && website != "http://"
  end

  def renting_type
    renting? ? "Renting Member" : "Non-Renting/Subletting"
  end

  def prefers_email?
    contact_method == 'email'
  end

  ## Class methods

  def self.contact_list_csv
    FasterCSV.generate do |csv|
      csv << ["Clifton Studios Contact List"]
      csv << ["Generated: #{Time.now.to_s(:with_time)}"]
      csv <<
      csv << ["Name", "Address", "Phone", "Alternate Phone", "Email Address"]
      Member.active.alphabetical.each do |member|
        csv << member.to_csv
      end
    end
  end

  def self.for_artists_index
    active.sort{|a, b| a.last_name <=> b.last_name }
  end

  def change_password!
    password = MemorablePassword.generate :min_length => PASSWORD_MIN_LENGTH

    self.password = password
    self.password_confirmation = password
    self.password_configured = false

    save!

    password
  end

  protected

  ## Callbacks and validations

  def website_begins_with_protocol
    errors.add(:website, "must begin with 'http://' or 'https://'") unless website =~ /http(s)?:\/\/.+/ || website.blank? || website == "http://"
  end

  def set_default_password
    if new_record? && password.blank? && password_confirmation.blank?
      password = MemorablePassword.generate :min_length => PASSWORD_MIN_LENGTH

      self.password = password
      self.password_confirmation = password
      self.password_configured = false
    end
    true
  end

  def create_secret_hash
    self.secret_hash = Digest::SHA1.hexdigest(rand.to_s) if self.secret_hash.blank?
    true
  end

  def subletting_and_associated
    if renting?
      self.errors[:base] << "A renting member must not also be marked as subletting" if subletting_member
    end
  end

  def member_since_format
    errors.add(:member_since_year, "must be set if a month is selected") if member_since_year.blank? && member_since_month.present?
  end

  def set_member_since
    self.member_since_month = Date::MONTHNAMES[Date.today.month]
    self.member_since_year = Date.today.year
  end

end
