class PostsController < ApplicationController

  def index
    @posts = Post.sorted.paginate(pagination_params)
    @title = "News"
  end

  def show
    @post = Post.find_by_permalink(params[:id])
    @title = "News - #{@post.title}"
  end

  def rss
    @items = (Post.sorted + Event.order("starts_at DESC")).sort{|x,y| y.sort_by <=> x.sort_by}

    respond_to do |wants|
      wants.xml do
        render :layout => false
      end
    end
  end

end
