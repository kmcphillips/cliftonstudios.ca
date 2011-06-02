class Members::DashboardController < ApplicationController
  before_filter :require_member

  def index
    @title = "Dashboard"
  end

  def update
    @title = "Dashboard"

    if current_member.update_attributes(params[:member])
      redirect_to members_dashboard_index_path, :notice => "Your profile has been updated"
    else
      render :index
    end
  end
end
