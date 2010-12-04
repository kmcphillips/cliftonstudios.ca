class PostsController < ApplicationController

  def index
    @posts = Post.sorted.paginate(pagination_params)
    @title = "News"
  end

  def show
    @post = Post.find_by_permalink(params[:id])
    @title = @post.title
  end
  
  def rss
    @items = (Post.sorted + Event.order("starts_at DESC")).sort{|x,y| x.sort_by <=> y.sort_by}

    respond_to do |wants|
      wants.xml do
        render :layout => false
      end
    end
  end

end
