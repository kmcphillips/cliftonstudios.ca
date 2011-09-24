class MailingListController < ApplicationController

  def create
    @entry = MailingListEntry.new(:email => params[:email], :ip_address => request.remote_ip)

    if !params[:validation].blank?
      flash[:error] = "Validation field must be blank. Are you a robot?"
    elsif @entry.save
      flash[:notice] = "Your email address has been added!"
    else
      flash[:error] = @entry.errors.full_messages.to_sentence
    end

    redirect_to request.referer
  end

end
