class PasswordResetController < ApplicationController

  def index
    if logged_in?
      redirect_to root_url
    end
  end

  def create
    if logged_in?
      redirect_to root_url
    else
      @member = Member.find_by_email params[:member].try(:[], :email)

      begin
        ActiveRecord::Base.transaction do
          if @member
            password = @member.reset_password!

            MemberMailer.reset_password(:member => @member, :password => password).deliver

            flash[:notice] = "Your password has been reset. A new password has been emailed to you. Please check your email."
            redirect_to login_path
          else
            flash[:error] = "Could not find a member with that email address."
            render :action => :index
          end
        end
      rescue => e
        flash[:error] = "There was an error resetting your password. Sorry about that. Please contact the administrator."
        logger.error "Could not reset password: #{e.message}"
        
        render :action => :index
      end
    end
  end
end

