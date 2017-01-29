class Executive < ActiveRecord::Base

  TITLES = ["President", "Vice President", "Vice President", "Membership Officer", "Secretary", "Treasurer"]

  include Audited

  belongs_to :member

  validates :title, :inclusion => {:in => TITLES, :message => "is not a valid executive title"}
  validates :sort_order, :presence => true, :uniqueness => true

  scope :sorted, ->{ order("sort_order ASC") }
  scope :filled, ->{ where("member_id IS NOT NULL") }
  scope :vacant, ->{ where("member_id IS NULL") }

  ## class methods

  def self.emails
    all.map(&:member).compact.map(&:email)
  end

  def self.to_sentence
    s = sorted.map{|e| e.member.try(:name)}.compact.to_sentence
    s.blank? ? "nobody" : s
  end

end

