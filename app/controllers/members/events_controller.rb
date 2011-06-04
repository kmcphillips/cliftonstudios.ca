class Members::EventsController < ApplicationController
  before_filter :require_member

  def index
    @events = Event.paginate(pagination_params(:order => "created_at DESC"))
  end

  def new
    @event = Event.new :member => current_member
  end

  def edit
    @event = Event.find_by_permalink(params[:id])
  end

  def create
    @event = current_member.events.build(params[:event])

    if params[:commit] == "Preview"
      @preview = true
      @event.created_at = Time.now
      render :action => "new"
    elsif @event.save
      redirect_to(members_events_path, :notice => 'News event was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @event = Event.find_by_permalink(params[:id])

    if params[:commit] == "Preview"
      @event.attributes = params[:event]
      @preview = true
      render :action => "new"
    elsif @event.update_attributes(params[:event])
      redirect_to(members_events_path, :notice => 'News event was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to(members_events_path)
  end
end

