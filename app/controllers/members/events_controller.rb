class Members::EventsController < ApplicationController
  def index
    @events = Event.paginate(pagination_params(:order => "created_at DESC"))
  end

  def new
    @event = Event.new :member => current_member
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = current_member.event.build(params[:event])

    if @event.save
      redirect_to(member_events_path, :notice => 'News event was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to(member_events_path, :notice => 'News event was successfully updated.') 
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

