class Admins::PostsController < ApplicationController

  before_filter :check_if_admin
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    unless params[:post][:tag_ids].blank?
      tag_ids = params[:post][:tag_ids][0].split(/,/)
      tag = tag_ids  
      params[:post][:tag_ids] = Tag.find(tag).collect(&:id)
    end
    params[:post][:tag_ids] ||= []
    @post = Post.new(post_params)
    if @post.save
      redirect_to admins_posts_path, :notice => "Post Created"
    else
      redirect_to new_admins_post, :alert => "Something went wrong"
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    unless params[:post][:tag_ids].blank?
      tag_ids = params[:post][:tag_ids][0].split(/,/)
      tag = tag_ids  
      params[:post][:tag_ids] = Tag.find(tag).collect(&:id)
    end
    params[:post][:tag_ids] ||= []
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    redirect_to admins_posts_path, :notice => "Post Updated"
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admins_posts_path, :notice => "Post Deleted Successfully."
  end
  
  def search
    if params[:q]
     tags = Tag.where("content like ?", "%#{params[:q]}%")
   else
     tags = Tag.all
   end
    list = tags.all.map{|u| Hash[ content: u.content, id: u.id ]} 
    render json: list
  end
  
  protected

  def check_if_admin
    if signed_in?
      redirect_to "/", :notice => "You are not admin..."  unless current_admin.present?
    else
      redirect_to "/", :notice => "Please sign in..."  
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :avatar, :avatar_cache, :tag_ids => [] )
  end
  
end
