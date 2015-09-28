class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :edit, :update, :destroy]
  def create
    @place = Place.find(params[:place_id])
    @place.comments.create(comment_params.merge(:user => current_user))
    redirect_to place_path(@place)
  end

  # edit_place_comment_path(place, comment)
  # edit_comment_path(comment)
  def edit
    @comment = current_user.comments.find(params[:id])
   
  end
  
  def update
    @comment = current_user.comments.find(params[:id])
   
  
    @comment.update_attributes(comment_params)
    if @comment.valid?
      redirect_to root_path
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    
    @comment.destroy
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :rating)
  end
end
