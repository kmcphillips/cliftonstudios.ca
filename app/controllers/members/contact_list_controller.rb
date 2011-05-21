class Members::ContactListController < ApplicationController
  before_filter :require_member

  def index
    respond_to do |format|
      format.html do
        @members = Member.active.alphabetical.each
      end
      
      format.csv do
        send_data Member.contact_list_csv,
                :type => 'text/csv; charset=iso-8859-1; header=present',
                :disposition => "attachment; filename=clifton_studios_members_#{Time.now.to_s(:filename)}.csv"
      end
    end
  end

end

