class Members::MembersController < ApplicationController
  before_filter :require_admin_member

  def index
    @active_members = Member.public.active.alphabetical
    @inactive_members = Member.public.inactive.alphabetical
  end

  def new
    @member = Member.new
  end

  def show
    @member = Member.public.find_by_permalink!(params[:id])
  end

  def edit
    @member = Member.public.find_by_permalink!(params[:id])
  end

  def create
    @member = Member.new(params[:member])

    if @member.save
      redirect_to(members_members_path, :notice => "#{@member.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    @member = Member.public.find_by_permalink!(params[:id])

    if @member.update_attributes(params[:member])
      redirect_to(members_members_path, :notice => "#{@member.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def password_reset
    @member = Member.public.find_by_permalink!(params[:id])
    @member.deliver_forgotten_password!
    redirect_to(members_member_path(@member), notice: "A password reset email has been sent!")
  end

end
