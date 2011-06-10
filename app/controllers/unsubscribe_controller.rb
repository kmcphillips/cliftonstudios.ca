class UnsubscribeController < ApplicationController

  def edit
    @member = Member.find_by_email_and_secret_hash(params[:id], params[:key])
  end

  def update
    @member = Member.find_by_email_and_secret_hash(params[:id], params[:key])

    if @member && @member.update_attribute(:receive_emails, false)
      flash[:notice] = "You have been unsubscribed. Your email preference has been updated in your profile."
    else
      flash[:error] = "There was an error unsubscribing you. Please email your administrator."
    end

    redirect_to root_path
  end

end
