class Picture < ActiveRecord::Base

  include AttachedImage
  
  belongs_to :member

  validates :member, :presence => true

  scope :sorted, order("created_at DESC")

  ## Class methods

  def self.members_recently_updated(count=4)
    
  end

  def self.members_with_pictures
    
  end

end

