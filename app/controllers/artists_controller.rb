class ArtistsController < ApplicationController
  
  def index
    @title = "Artists"
    @members = Member.for_artists_index
    @executive = Executive.filled.sorted
  end

  def show
    @member = Member.find_by_permalink(params[:id])
    @title = @member.name
  end
  
end
