class PicturesController < ApplicationController

  def index
    @title = "Picture Gallery"
    @member = Picture.members_with_pictures
  end

  def show
    if params[:id] == "all"
      @title = "All Pictures"
      @pictures = Picture.sorted.paginate pagination_params(:per_page => 16)
      render "all"
    else
      @member = Member.find_by_permalink params[:id]
      @title = "Picture Gallery for #{@member.name}"
      @pictures = @member.pictures.sorted.paginate pagination_params(:per_page => 16)
    end
  end

end

