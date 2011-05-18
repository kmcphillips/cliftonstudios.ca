class Member < ActiveRecord::Base
  
  acts_as_authentic
  acts_as_permalink :from => :name
  
  include AttachedImage
  
  has_many :posts
  has_many :pictures
  
  validates :name, :presence => {:message => "must be set"}

  def reset_password!
    password = MemorablePassword.generate

    self.password = password
    self.password_confirmation = password
    self.password_configured = false

    if save
      password
    end
  end

end
