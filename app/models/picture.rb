class Picture < ActiveRecord::Base

  include AttachedImage
  
  belongs_to :member

  validates :member, :presence => true

  scope :sorted, order("created_at DESC")
  scope :active, where("members.active = 1").joins(:member)
  scope :random, lambda {|size| active.order("RAND()").limit(size || 4) }
  scope :recent, sorted.limit(4)

  ## Class methods

  def self.members_recently_updated(count=4)
    ## I do not know how to do this in SQL without losing the sort order of the most recent pictures
    Member.joins(:pictures).order("pictures.created_at desc").uniq.first(count)
  end

  def self.recent_grouped_by_artist(count=4)
    members_recently_updated(count).map{|m| m.pictures.first }
  end

  def self.members_with_pictures
    Member.select("distinct members.*").joins(:pictures).sort{|a, b| a.last_name <=> b.last_name }
  end

end

