class Members::ContactListController < ApplicationController
  before_filter :require_member

  def index
    respond_to do |format|
      format.html do
        @title = "Contact List"
        @members = Member.active.alphabetical
      end
      
      format.csv do
        send_data Member.contact_list_csv,
                :type => 'text/csv; charset=iso-8859-1; header=present',
                :disposition => "attachment; filename=clifton_studios_members_#{Time.now.to_s(:filename)}.csv"
      end
    end
  end

  def print
    @members = Member.active.alphabetical

    render :layout => "print_contact_list"
  end

end

