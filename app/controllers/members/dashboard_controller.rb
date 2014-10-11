class Members::DashboardController < ApplicationController
  before_filter :require_member

  def index
    @title = "Dashboard"
  end

  def update
    @title = "Dashboard"

    if current_member.update_attributes(member_params)
      redirect_to members_dashboard_index_path, :notice => "Your profile has been updated"
    else
      render :index
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :address, :phone, :alternate_phone, :contact_method, :receive_emails, :bio, :website, :delete_image, :image)
  end

end
