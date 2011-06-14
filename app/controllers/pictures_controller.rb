class PicturesController < ApplicationController

  def index
    @title = "Picture Gallery"
    @pictures = Picture.sorted.paginate pagination_params(:per_page => 16)
  end

  def show
    @member = Member.find_by_permalink params[:id]
    @title = "Picture Gallery for #{@member.name}"
    @pictures = @member.pictures.sorted.paginate pagination_params(:per_page => 16)
  end

end
