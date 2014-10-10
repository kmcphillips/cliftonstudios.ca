class EventsController < ApplicationController

  def index
    @title = "Events"
    @events = Event.upcoming.paginate(pagination_params)
    @past_events = Event.past.group_by{|e| e.starts_at.year }
  end

  def show
    @event = Event.find_by_permalink(params[:id])
    @title = "Event - #{@event.title}"
  end
end
