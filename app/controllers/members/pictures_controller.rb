class Members::PicturesController < ApplicationController
  before_filter :require_member

  def index
    @picture = Picture.new
    @pictures = current_member.pictures.paginate pagination_params
  end

  def create
    @picture = current_member.pictures.build(params[:picture])

    if @picture.save
      flash[:notice] = "Picture uploaded successfully!"
      redirect_to members_pictures_path
    else
      @pictures = current_member.pictures.paginate pagination_params
      render :index
    end
  end

  def update
  end

  def destroy
  end

  def all
    @pictures = Picture.paginate pagination_params
  end
end

