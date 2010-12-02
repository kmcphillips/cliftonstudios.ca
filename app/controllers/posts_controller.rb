class PostsController < ApplicationController

  def index
    @posts = Post.sorted.paginate
  end

  def show
    @post = Post.find(params[:id])
  end
end
