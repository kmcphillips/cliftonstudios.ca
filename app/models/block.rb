class Block < ActiveRecord::Base
  validates :label, :presence => true
  validates :path, :presence => true

  attr_protected :label, :path
  
  include AttachedImage

end
