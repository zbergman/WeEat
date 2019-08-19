class RestaurantsController < ApplicationController
  def index
    Restaurant.sorted
  end

  def show
    Restaurant.find(params[:id])
  end

  def new
    Restaurant.new
  end

  def create
    Restaurant.new(restaurants_params)
  end

  def edit

  end

  def update

  end

  def delete

  end

  def destroy

  end

  def restaurants_params
    params.require(:restaurant).permit(:name, :cuisine, :rating, :is_10_bis, :address, :max_delivery_time_in_minutes)
  end
end
