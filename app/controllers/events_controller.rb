class EventsController < ApplicationController

  def index
    @title = "Events"
    @events = Event.upcoming.paginate(pagination_params)
  end

  def show
    @event = Event.find(params[:id])
    @title = "Event :: #{@event.title}"
  end
end
