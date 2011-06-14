class Picture < ActiveRecord::Base

  include AttachedImage
  
  belongs_to :member

  validates :member, :presence => true

  scope :sorted, order("created_at DESC")

  ## Class methods

  def self.recently_updated(count=4)
    
  end

end

