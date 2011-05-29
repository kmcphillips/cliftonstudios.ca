class Members::ExecutiveController < ApplicationController
  before_filter :require_member

  def index
    @members = Member.alphabetical.active
    @executive = Executive.sorted
  end

  def create # actually update for current_user
    Executive.sorted.each do |position|
      position.update_attribute(:member_id, params[position.id.to_s]) if params[position.id.to_s]
    end

    flash[:error] = "Executive has been updated."

    redirect_to members_executive_index_path
  end

end

