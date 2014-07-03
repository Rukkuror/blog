class Admins::TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.create(tags_params)
    if @tag.save
      redirect_to admins_tags_path, :notice => "Tag Created"
    else
      redirect_to new_admins_tag, :alert => "Something went wrong"
    end
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(tags_params)
      redirect_to admins_tags_path, :notice => "Tag Updated"
    else
      redirect_to edit_admins_tag_path(@tag), :alert => "Tag already present."
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admins_tags_path, :notice => "Tag Deleted Successfully."
  end
  
  private

  def tags_params
    params.require(:tag).permit(:content)
  end
  
end
