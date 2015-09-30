class CommentsController < ApplicationController
  before_action :get_parent, :only => [:update, :destroy]
  before_action :authenticate_user!, :only => [:create, :edit, :update, :destroy]

  def create
    @place = Place.find(params[:place_id])
    @place.comments.create(comment_params.merge(:user => current_user))
    redirect_to place_path(@place)
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
     
    @comment.update_attributes(comment_params)
    if @comment.valid?
      redirect_to @parent
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id]) 

    if @comment.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  
    @comment.destroy
    redirect_to @parent
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :rating)
  end

  def get_parent
    if params[:place_id].present?
      @parent = Place.find(params[:place_id])
    elsif params[:user_id].present?
      @parent = User.find(params[:user_id])
    end
  end
end
