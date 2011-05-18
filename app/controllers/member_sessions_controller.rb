class MemberSessionsController < ApplicationController

  before_filter :require_no_member, :only => [:new, :create]
  before_filter :require_member, :only => :destroy

  def new
    @member_session = MemberSession.new
  end

  def create
    @member_session = MemberSession.new(params[:member_session])
    if @member_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default "/"
    else
      render :action => :new
    end
  end

  def destroy
    current_member_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default "/"
  end

end
