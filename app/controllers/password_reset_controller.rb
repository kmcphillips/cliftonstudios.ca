class PasswordResetController < ApplicationController

  before_filter :require_no_member

  def index 
  end

  def create
    @member = Member.find_by_email params[:email]

    if @member
      password = @member.reset_password!

      MemberMailer.reset_password(@member, password).deliver
      
      flash[:notice] = "Your password has been reset. A new password has been emailed to you."
      redirect_to login_path
    else
      flash[:error] = "Could not find a member with that email address"
      render :action => :index
    end
  end
end

