class Post < ActiveRecord::Base
  STATUSES = ["unsent", "sending", "sent"]
  
  acts_as_permalink
  include AttachedImage
  
  belongs_to :member
  
  validates :title, :presence => true
  validates :member, :presence => true
  validates :body, :presence => true
  validates :status, :inclusion => {:in => STATUSES}
  
  STATUSES.each do |status|
    scope status, where(:status => status)
  end
  
  scope :sorted, order("created_at DESC")
  
end
