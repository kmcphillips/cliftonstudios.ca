class Event < ActiveRecord::Base
  STATUSES = ["unsent", "sending", "sent"]
  
  acts_as_permalink
  include AttachedImage
  
  belongs_to :member
  
  validates :title, :presence => true
  validates :member, :presence => true
  validates :body, :presence => true
  validates :status, :inclusion => {:in => STATUSES}
  
  before_save :set_ends_at
  
  STATUSES.each do |status|
    scope status, where(:status => status)
  end
  
  def sort_by; starts_at; end
  
  scope :upcoming, lambda{ where("ends_at > #{Time.now}").order("starts_at DESC") }

  protected
  
  def set_ends_at
    ends_at = starts_at.beginning_of_day + duration.days
  end
end
