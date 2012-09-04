class Event < ActiveRecord::Base

  acts_as_permalink
  include AttachedImage
  
  belongs_to :member
  
  validates :title, :presence => true
  validates :member, :presence => true
  validates :body, :presence => true

  before_save :set_ends_at

  def sort_by; starts_at; end
  
  scope :upcoming, lambda{ where(["ends_at > ?", Time.now]).order("starts_at DESC") }
  scope :past, lambda{ where(["ends_at < ?", Time.now]).order("starts_at DESC") }
  scope :sorted, order("created_at DESC")

  def prefix
    if Time.now < self.starts_at
      "Happens on"
    elsif Time.now >= self.starts_at && Time.now < self.starts_at
      "Happening now"
    else
      "Happened on"
    end
  end

  class << self

    def next_two_meetings
      result = []
      date = Date.today.beginning_of_month

      while result.size != 2
        if date.month == 10 || date.month == 4
          meeting = date

          while meeting.cwday != 4
            meeting = meeting + 1.day
          end

          result << meeting if meeting >= Date.today
        end

        date = date + 1.month
      end

      result
    end

  end

  protected
  
  def set_ends_at
    self.ends_at = self.starts_at.beginning_of_day + duration.days
  end
end
