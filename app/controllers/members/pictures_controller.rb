class Members::PicturesController < ApplicationController
  before_filter :require_member, :except => [:all]
  before_filter :require_admin_member, :only => [:all]

  def index
    @picture = Picture.new
    @pictures = current_member.pictures.sorted.paginate pagination_params(:per_page => 8)
  end

  def create
    @picture = current_member.pictures.build(picture_params)

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

    if @picture.update_attributes(picture_params)
      redirect_to members_pictures_path, :notice => "Picture description updated successfully"
    else
      render :edit
    end
  end

  def destroy
    # This should probably be two methods, but the public interface is cleaner. Only admin can delete someone else's pictures.
    if current_member.admin?
      Picture.find(params[:id]).destroy
    else
      current_member.pictures.find(params[:id]).destroy
    end

    redirect_to members_pictures_path, :notice => "Picture deleted successfully"
  end

  def all
    @pictures = Picture.sorted.paginate pagination_params(:per_page => 16)
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :description)
  end
end

