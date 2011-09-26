class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_member_session, :current_member, :logged_in?

  before_filter :set_member_tracker

  private
  
  def pagination_params(opts={})
    {:page => params[:page] || 1, :per_page => PAGINATION_PER_PAGE}.merge(opts)
  end
  
  ## AuthLogic
  
  def current_member_session
    return @current_member_session if defined?(@current_member_session)
    @current_member_session = MemberSession.find
  end

  def current_member
    return @current_member if defined?(@current_member)
    @current_member = current_member_session && current_member_session.member
  end

  def logged_in?
    !!current_member
  end

  def require_member
    unless current_member
      flash[:error] = "You must be logged in to view that page."
      redirect_to login_path
      return false
    end
  end

  def set_member_tracker
    MemberTracker.current = current_member
  end

end

