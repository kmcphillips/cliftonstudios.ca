class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_member_session, :current_member, :logged_in?

  prepend_before_filter :readonly_mode_check
  append_before_filter :set_member_tracker, :find_random_pictures

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

    true
  end

  def require_admin_member
    if require_member
      if !current_member.admin?
        flash[:error] = "You must be a site administrator view that page."
        redirect_to members_dashboard_index_path
        return false
      end
    end

    true
  end

  def set_member_tracker
    MemberTracker.current = MemberSession.find.try(:member)
  end

  def find_random_pictures
    @random_pictures = Picture.random(3)
  end

  def readonly_mode_check
    if SystemVariable.readonly? && current_member_session && !current_member_session.member.system?
      current_member_session.destroy
      redirect_to login_path
    end

    true
  end

end

