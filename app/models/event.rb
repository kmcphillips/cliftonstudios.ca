class Event < ActiveRecord::Base

  acts_as_permalink
  include AttachedImage
  include Audited
  include EmailOnCreate

  belongs_to :member

  validates :title, :presence => true
  validates :member, :presence => true
  validates :body, :presence => true

  before_save :set_ends_at

  def sort_by; starts_at; end

  scope :upcoming, ->{ where(["ends_at > ?", Time.now]).order("starts_at DESC") }
  scope :past, ->{ where(["ends_at < ?", Time.now]).order("starts_at DESC") }
  scope :sorted, ->{ order("created_at DESC") }

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

    # The first Thursday in April and October
    def next_two_meetings
      result = []
      date = Date.today.beginning_of_month

      while result.size < 2
        if date.month == 4 || date.month == 10
          event = date

          while !event.tuesday?
            event = event + 1.day
          end

          if event >= Date.today
            result << event
          end
        end

        date = date.end_of_month + 1.day
      end

      result
    end

    # Saturday the week before Mother's Day. Mother's day is the second sunday in May. This makes the sale the first Sunday in May minus one day.
    # Last Saturday of November and the Sunday immediately after
    def next_two_sales
      result = []
      date = Date.today.beginning_of_month

      while result.size < 2
        if date.month == 5
          event = date

          while !event.sunday?
            event = event + 1.day
          end

          event = event - 1.day

          result << event if event >= Date.today

        elsif date.month == 12
          event = date - 1.day

          while !event.saturday?
            event = event - 1.day
          end

          if event + 1.day >= Date.today
            result << [event, event + 1.day]
          end
        end

        date = date.end_of_month + 1.day
      end

      result
    end

  end

  protected

  def set_ends_at
    self.ends_at = self.starts_at.beginning_of_day + duration.days if self.starts_at
  end
end
