class Members::ExecutiveController < ApplicationController
  before_filter :require_admin_member

  def index
    @title = "Manage Executive"
    @members = Member.alphabetical.active.visible
    @executive = Executive.sorted
  end

  def create # actually update for current_user
    Executive.sorted.each do |position|
      position.update_attribute(:member_id, params[position.id.to_s]) if params[position.id.to_s]
    end

    flash[:notice] = "Executive has been updated."

    redirect_to members_executive_index_path
  end

end

