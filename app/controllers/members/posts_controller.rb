class Members::PostsController < ApplicationController
  before_filter :require_member

  def index
    @posts = Post.paginate(pagination_params(:order => "created_at DESC"))
  end

  def new
    @post = Post.new :member => current_member
  end

  def edit
    @post = Post.find_by_permalink(params[:id])
  end

  def create
    @post = current_member.posts.build(post_params)

    if params[:commit] == "Preview"
      @preview = true
      @post.created_at = Time.now
      render :action => "new"
    elsif @post.save
      redirect_to(members_posts_path, :notice => 'News post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find_by_permalink(params[:id])

    if params[:commit] == "Preview"
      @post.attributes = post_params
      @preview = true
      render :action => "new"
    elsif @post.update_attributes(post_params)
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

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :delete_image)
  end
end

