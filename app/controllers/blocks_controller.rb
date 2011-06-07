class BlocksController < ApplicationController
  before_filter :load_block  

  def about
    @about = @block
    @availability = Block.find_by_label("availability")
    @title = "About"
  end

  def links
    @links = Link.order("created_at ASC")
    @title = "Links"
  end

  def search
    redirect_to "http://www.google.ca/search?q=site%3Acliftonstudios.ca+#{URI.escape(params[:search] || "")}"
  end

  protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
