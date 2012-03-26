class Members::ContactExecutiveController < ApplicationController
  before_filter :require_member

  def index
  end

  def create
    @executive = Executive.sorted

    if params[:subject].blank? || params[:message].blank?
      flash[:error] = "Subject and message body cannot be blank."
      render :index
    else
      PendingEmail.create_executive_message!(params[:subject], params[:message], current_member, params[:anonymous])

      flash[:notice] = "Your message has been sent!"
      redirect_to members_dashboard_index_path
    end
  end

end
