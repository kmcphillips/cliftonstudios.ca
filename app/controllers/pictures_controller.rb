class PicturesController < ApplicationController

  def index
    @title = "Picture Gallery"
    @pictures = Picture.sorted.paginate pagination_params(:per_page => 16)
  end

  def show
    @picture = Picture.find_by_id
  end

end
