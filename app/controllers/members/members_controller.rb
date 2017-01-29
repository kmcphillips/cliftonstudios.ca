class Members::MembersController < ApplicationController
  before_filter :require_admin_member

  def index
    @active_members = Member.visible.active.alphabetical
    @inactive_members = Member.visible.inactive.alphabetical
  end

  def new
    @member = Member.new
  end

  def show
    @member = Member.visible.find_by_permalink!(params[:id])
  end

  def edit
    @member = Member.visible.find_by_permalink!(params[:id])
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to(members_members_path, :notice => "#{@member.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @member = Member.visible.find_by_permalink!(params[:id])

    if @member.update_attributes(member_params)
      redirect_to(members_members_path, :notice => "#{@member.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def password_reset
    @member = Member.visible.find_by_permalink!(params[:id])
    @member.deliver_forgotten_password!
    redirect_to(members_member_path(@member), notice: "A password reset email has been sent!")
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :address, :phone, :alternate_phone, :contact_method, :receive_emails, :active, :admin, :space_number, :member_since_month, :member_since_year, :renting, :subletting_member_id, :password, :password_confirmation, :bio, :website)
  end
end
