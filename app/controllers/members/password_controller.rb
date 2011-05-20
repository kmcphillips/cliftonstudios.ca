class Members::PasswordController < ApplicationController
  before_filter :require_member

  def index
  end

  def create # actually update for current_user
    if current_member.update_attributes(params[:member])
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
