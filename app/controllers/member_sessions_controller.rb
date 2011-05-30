class MemberSessionsController < ApplicationController

  before_filter :require_member, :only => :destroy

  def new
    @title = "Member Login"

    if current_member
      redirect_to members_dashboard_index_path
    else
      @member_session = MemberSession.new
    end
  end

  def create
    @member_session = MemberSession.new(params[:member_session])

    if @member_session.save
      flash[:notice] = "Hello #{current_member.name}!"
      
      if !current_member.password_configured?
        redirect_to members_password_index_path
      elsif !current_member.profile_configured?
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

end
