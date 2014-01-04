class ArtistsController < ApplicationController
  
  def index
    @title = "Artists"
    @members = Member.public.for_artists_index
  end

  def show
    @member = Member.public.active.find_by_permalink!(params[:id])
    @title = @member.name
  end
  
end
