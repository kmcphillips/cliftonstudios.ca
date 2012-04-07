class Members::MinutesController < ApplicationController
  before_filter :require_member, :only => [:index]
  before_filter :require_admin_member, :only => [:create, :destroy]

  def index
    @minutes = Minutes.new
    @existing_minutes = Minutes.sorted
  end

  def create
    @minutes = current_member.minutes.build(params[:minutes])

    if @minutes.save
      redirect_to members_minutes_index_path, :notice => "Minutes uploaded successfully!"
    else
      @existing_minutes = Minutes.sorted
      render :index
    end
  end

  def destroy
    Minutes.find(params[:id]).destroy

    redirect_to members_minutes_index_path, :notice => "Minutes deleted successfully!"
  end

end
