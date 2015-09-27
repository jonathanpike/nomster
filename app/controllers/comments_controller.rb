class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :edit, :update, :destroy]
  def create
    @place = Place.find(params[:place_id])
    @place.comments.create(comment_params.merge(:user => current_user))
    redirect_to place_path(@place)
  end

  def edit
    @place = Place.find(params[:id])

    if @place.comments.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.comments.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @place.update_attributes(comment_params)
    if @place.comments.valid?
      redirect_to root_path
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.comments.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @place.comments.destroy
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :rating)
  end
end
