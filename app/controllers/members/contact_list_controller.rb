class Members::ContactListController < ApplicationController
  before_filter :require_member

  def index
    @members = Member.active.alphabetical.each

    respond_to do |format|
      format.html
      format.xls do
        send_data @members.to_xls_data(:columns => Member.columns), :filename => "clifton_studios_members_#{Time.now.to_s[:filename]}.xls" 
      end
    end
  end

end

