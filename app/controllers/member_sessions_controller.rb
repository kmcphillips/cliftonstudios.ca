class MemberSessionsController < ApplicationController

  before_filter :require_member, :only => :destroy

  def new
    @title = "Member Login"

    if SystemVariable.readonly?
      flash[:error] = "Warning: The system is in read only mode for maintenance. You will not be able to long in temporarily. Sorry for the inconvenience."
    end

    if logged_in?
      redirect_to members_dashboard_index_path
    else
      @member_session = MemberSession.new
    end
  end

  def create
    @title = "Member Login"

    @member_session = MemberSession.new(member_session_params)
    binding.pry
    if @member_session.save

      if SystemVariable.readonly? && !@member_session.member.system?
        @member_session.destroy
        redirect_to login_path
        return
      end

      flash[:notice] = "Hello #{@member_session.member.name}!"

      if !@member_session.member.password_configured?
        redirect_to members_password_index_path
      elsif !@member_session.member.profile_configured?
        redirect_to members_profile_index_path
      else
        redirect_to members_dashboard_index_path
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_member_session.destroy
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end

  private

  def member_session_params
    params.require(:member_session).permit(:email, :password, :remember_me)
  end

end
