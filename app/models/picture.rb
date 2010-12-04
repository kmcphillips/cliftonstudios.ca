class Picture < ActiveRecord::Base

  include AttachedImage
  
  belongs_to :member



end
