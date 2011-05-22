class PasswordResetController < ApplicationController

  def index
    if current_member
      redirect_to root_url
    end
  end

  def create
    if current_member
      redirect_to root_url
    else
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
end

