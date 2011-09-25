class Members::PicturesController < ApplicationController
  before_filter :require_member

  def index
    @picture = Picture.new
    @pictures = current_member.pictures.sorted.paginate pagination_params(:per_page => 8)
  end

  def create
    @picture = current_member.pictures.build(params[:picture])

    if @picture.save
      redirect_to members_pictures_path, :notice => "Picture uploaded successfully!"
    else
      @pictures = current_member.pictures.paginate pagination_params
      render :index
    end
  end

  def edit
    @picture = current_member.pictures.find params[:id]
  end

  def update
    @picture = current_member.pictures.find params[:id]

    if @picture.update_attributes(params[:picture])
      redirect_to members_pictures_path, :notice => "Picture description updated successfully"
    else
      render :edit
    end
  end

  def destroy
    current_member.pictures.find(params[:id]).destroy
    redirect_to members_pictures_path, :notice => "Picture deleted successfully"
  end

  def all
    @pictures = Picture.paginate pagination_params(:per_page => 16)
  end
end

