class Members::DashboardController < ApplicationController
  before_filter :require_member

  def index
    @title = "Dashboard"
  end

end
