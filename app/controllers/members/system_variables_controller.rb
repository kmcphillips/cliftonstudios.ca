class Members::SystemVariablesController < ApplicationController

  def index
    if current_member.system?
      @readonly = SystemVariable.find_by_key "readonly"
    else
      flash[:error] = "You are not allowed to view that page"
      redirect_to members_dashboard_index_path
    end
  end

  def update
    if current_member.system?

      SystemVariable.find(params[:id]).try(:update_attribute, :value, params[:system_variable][:value])

      redirect_to members_system_variables_path
    else
      flash[:error] = "You are not allowed to view that page"
      redirect_to members_dashboard_index_path
    end
  end

end
