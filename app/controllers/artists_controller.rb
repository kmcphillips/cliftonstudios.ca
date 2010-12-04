class ArtistsController < ApplicationController
  
  def index
    @members = Member.order("name ASC")
  end

  def show
    @member = Member.find_by_permalink(params[:id])
  end
  
end
