class Picture < ActiveRecord::Base

  include AttachedImage
  
  belongs_to :member

  scope :sorted, order("created_at DESC")

end
