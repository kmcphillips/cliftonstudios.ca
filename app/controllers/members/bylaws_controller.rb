class Members::BylawsController < ApplicationController
  before_filter :require_member, only: [:index]
  before_filter :require_admin_member, except: [:index]
  before_filter :load_bylaw, only: [:update, :destroy, :edit]

  def index
    @bylaws = Document.bylaws.sorted
  end

  def new
    @bylaw = current_member.documents.build(kind: 'bylaw')
  end

  def edit
  end

  def create
    @bylaw = current_member.documents.build(params[:document])
    @bylaw.kind = 'bylaw'

    if @bylaw.save
      redirect_to members_bylaws_path, notice: "Bylaws uploaded successfully!"
    else
      render :new
    end
  end

  def update
    if @bylaw.update_attributes(params[:document])
      redirect_to members_bylaws_path, notice: "Bylaws updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @bylaw.destroy

    redirect_to members_bylaws_path, notice: "Bylaws deleted successfully!"
  end

  protected

  def load_bylaw
    @bylaw = Document.bylaws.find(params[:id])
  end

end
