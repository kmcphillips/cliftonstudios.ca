class Minutes < ActiveRecord::Base

  belongs_to :member

  has_attached_file :file,
    :whiny => true,
    :path => ":rails_root/public/assets/minutes/:filename",
    :url => "/assets/minutes/:filename"

  validates :description, :presence => true
  validates :recorded_at, :presence => true
  validates_attachment_size :file, :in => 1..10.megabytes
  validates_attachment_presence :file
  
  scope :sorted, order("recorded_at DESC")

end