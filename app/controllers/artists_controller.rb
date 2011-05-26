class ArtistsController < ApplicationController
  
  def index
    @members = Member.order("name ASC")
    @executive = Executive.filled.sorted
  end

  def show
    @member = Member.find_by_permalink(params[:id])
  end
  
end
