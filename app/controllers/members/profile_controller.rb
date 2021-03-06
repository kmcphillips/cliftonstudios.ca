class Members::ProfileController < ApplicationController
  before_filter :require_member

  def index
  end

  def create # actually update for current_user
    if current_member.update_attributes(member_params)
      if current_member.profile_configured?
        flash[:notice] = "Your profile has been updated but it is still missing a few things. You can fix it later."
      else
        flash[:notice] = "Your profile has been updated."
      end

      redirect_to members_dashboard_index_path
    else
      render :index
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :address, :phone, :alternate_phone, :receive_emails, :contact_method)
  end
end
