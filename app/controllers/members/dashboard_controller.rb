class Members::DashboardController < ApplicationController
  before_filter :require_member

  def index
    @title = "Dashboard"
  end

  def create
    @title = "Dashboard"

    if current_user.update_attributes(params[:member])
      redirect_to members_dashboard_index_path, :notice => "Your profile has been updated"
    else
      render :index
    end
end

