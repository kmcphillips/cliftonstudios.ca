class Member < ActiveRecord::Base
  
  acts_as_authentic
  acts_as_permalink :from => :name
  
  include AttachedImage
  
  has_many :posts
  has_many :pictures
  
  validates :name, :presence => {:message => "must be set"}

  

end
