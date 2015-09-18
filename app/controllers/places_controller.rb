class PlacesController < ApplicationController
  def index
    @places = Place.order(:created_at).page(params[:page]).per(10)
  end

  def new
    @places = Place.new
  end
end
