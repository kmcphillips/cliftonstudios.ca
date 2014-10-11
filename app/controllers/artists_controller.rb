class ArtistsController < ApplicationController

  def index
    @title = "Artists"
    @members = Member.visible.for_artists_index
  end

  def show
    @member = Member.visible.active.find_by_permalink!(params[:id])
    @title = @member.name
  end

end
