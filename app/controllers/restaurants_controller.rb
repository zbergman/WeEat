class RestaurantsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    Restaurant.create(restaurants_params)
  end

  def edit
    Restaurant.find(params[:id])
  end

  def update
    restaurant = Restaurant.find(params[:id])

    if restaurant
      restaurant.update_attributes(restaurants_params)
    end
  end

  def delete
    Restaurant.find(params[:id])
  end

  def destroy
    restaurant = Restaurant.find(params[:id])

    if restaurant
      restaurant.destroy
    end
  end

  private
  def restaurants_params
    params.require(:restaurant).permit(:name, :cuisine, :rating, :is_10_bis, :address, :max_delivery_time_in_minutes)
  end
end
