class Post < ActiveRecord::Base

  acts_as_permalink
  include AttachedImage
  include Audited
  include EmailOnCreate
  
  belongs_to :member
  
  validates :title, :presence => true
  validates :member, :presence => true
  validates :body, :presence => true

  scope :sorted, order("created_at DESC")
  
  def sort_by; created_at; end
  
  
end
