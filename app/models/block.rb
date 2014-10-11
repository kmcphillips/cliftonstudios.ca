class Block < ActiveRecord::Base
  validates :label, :presence => true, :uniqueness => true
  validates :path, :presence => true

  include AttachedImage
  include Audited

end
