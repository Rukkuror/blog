class PostsController < ApplicationController
  
  def index
    if params[:label].present?
      @tag = Tag.find_by_content(params[:label])
      @posts = @tag.posts.order("created_at DESC").flatten
    else
      @posts = Post.all.reverse.flatten
    end
    @recent_posts = Post.last(5).reverse
  end
  
  def show
    @post = Post.find_by_title(params[:id])
    @recent_posts = Post.last(5).reverse
  end
  
end
