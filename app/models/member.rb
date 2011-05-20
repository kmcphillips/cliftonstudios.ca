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
    false # TODO: check some attributes here
  end

end
