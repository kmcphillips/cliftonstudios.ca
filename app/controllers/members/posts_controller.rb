class Members::PostsController < ApplicationController
  before_filter :require_member

  def index
    @posts = Post.paginate(pagination_params(:order => "created_at DESC"))
  end

  def new
    @post = Post.new :member => current_member
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_member.posts.build(params[:post])

    if @post.save
      redirect_to(members_posts_path, :notice => 'News post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to(members_posts_path, :notice => 'News post was successfully updated.') 
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to(members_posts_path)
  end
end

