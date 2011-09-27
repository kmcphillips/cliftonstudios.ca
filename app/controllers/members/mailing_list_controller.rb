class Members::MailingListController < ApplicationController
  before_filter :require_member

  def index
    @entries = MailingListEntry.active.paginate(pagination_params(:order => "created_at DESC", :per_page => 20))
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

  def create
    @entry = MailingListEntry.new(:email => params[:email])

    if @entry.save
      flash[:notice] = "Email address '#{params[:email]}' added."
    else
      flash[:error] = "Could not add email address. #{@entre.errors.full_messages.to_sentence}"
    end

    redirect_to members_mailing_list_index_path
  end

end
