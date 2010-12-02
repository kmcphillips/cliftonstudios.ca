class PostsController < ApplicationController

  def index
    @posts = Post.sorted.paginate(pagination_params)
  end

  def show
    @post = Post.find(params[:id])
  end
end
