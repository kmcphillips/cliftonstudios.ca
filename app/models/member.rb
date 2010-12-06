class Member < ActiveRecord::Base
  STATUSES = ["active", "admin", "deactive"]
  
  acts_as_authentic
  acts_as_permalink :from => :name
  
  include AttachedImage
  
  has_many :posts
  has_many :pictures
  
  validates :name, :presence => {:message => "must be set"}
  validates :status, :inclusion => {:in => STATUSES, :message => "is not a valid"}

  before_save :set_fingerprint, :on => :create

  IMAGE_SIZES.each_key do |key|
    define_method key do
      self.image.url(key)
    end
  end
  
  def admin?
    status == "admin"
  end
  
  def active?
    status && status != "deactive"
  end
  
  protected
  
  def set_fingerprint
    fingerprint = Digest::SHA1.hexdigest(Time.now.to_s + email)
  end
end
