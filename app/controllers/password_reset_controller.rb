class PasswordResetController < ApplicationController

  def index
    @title = "Forgotten Password"

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
            @member.deliver_forgotten_password!

            flash[:notice] = "Instructions for retrieving your password have been sent to you. Please check your email."
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

  def show
    @member = Member.find_by_perishable_token(params[:id])

    if @member
      MemberSession.create(@member)
      @member.update_attribute(:password_configured, false)

      flash[:notice] = "Hello #{@member.name}. Please enter a new password for your account."
      redirect_to members_password_index_path(forgotten: true)
    else
      flash[:error] = "Could not log you in with that token. It may have expired. Please try again or contact the administrator."
      redirect_to password_reset_index_path
    end
  end

end
