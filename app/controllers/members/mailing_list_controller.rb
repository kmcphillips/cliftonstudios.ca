class Members::MailingListController < ApplicationController
  before_filter :require_member

  def index
    @all_entries = MailingListEntry.active

    scope = MailingListEntry.active.sorted

    unless params[:search].blank?
      scope = scope.search(params[:search])
    end

    @entries = scope.paginate(pagination_params(per_page: 20))
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

  def bulk_create
    count = MailingListEntry.bulk_create(params[:emails])

    if count > 0
      flash[:notice] = "Added #{count} emails to the mailing list."
    else
      flash[:error] = "Added 0 emails. Either the format is incorrect, or all these emails have already been added."
    end

    redirect_to members_mailing_list_index_path
  end

end
