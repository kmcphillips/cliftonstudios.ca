class Members::PasswordController < ApplicationController
  before_filter :require_member

  def index
    @title = "Change Password"
  end

  def create # actually update for current_user
    @title = "Change Password"

    if params[:member].try(:[], :password).blank?
      flash[:error] = "Password cannot be blank."
      render :index
    elsif current_member.update_attributes(params[:member])
      current_member.update_attribute(:password_configured, true)
      flash[:notice] = "Password has been updated."

      if !current_member.profile_configured?
        redirect_to members_profile_index_path
      else
        redirect_to members_dashboard_index_path
      end

    else
      render :index
    end
  end
end
