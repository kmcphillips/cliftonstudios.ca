class EventsController < ApplicationController

  def index
    @events = Event.upcoming.paginate(pagination_params)
  end

  def show
    @event = Event.find(params[:id])
  end
end
