class Members::MailingListController < ApplicationController
  before_filter :require_member

  def index
    @entries = MailingListEntry.for_index
  end

  def update
    @entry = MailingListEntry.find_by_id(params[:id])

    if @entry
      @entry.deactivate!
      flash[:notice] = "Email address deactivated"
    else
      flash[:error] = "Could not find email to deactivate"
    end

    redirect_to members_mailing_list_index_path
  end

end
