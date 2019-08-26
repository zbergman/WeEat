class RestaurantsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { restaurants: Restaurant.sorted_by_name.map{|r| RestaurantSerializer.new(r)} }
  end

  def show
    render json: { restaurant: RestaurantSerializer.new(find_restaurant(params[:id])) }
  end

  def new
    render json: { restaurant: RestaurantSerializer.new(Restaurant.new) }
  end

  def create
    render json: { restaurant: RestaurantSerializer.new(Restaurant.create(restaurants_params)) }
  end

  def edit
    render json: { restaurant: RestaurantSerializer.new(find_restaurant(params[:id])) }
  end

  def update
    restaurant = find_restaurant(params[:id])
    restaurant.update_attributes(restaurants_params) if restaurant
  end

  def destroy
    restaurant = find_restaurant(params[:id])
    restaurant.destroy if restaurant
  end

  private
  def restaurants_params
    params.require(:restaurant).permit(:name, :cuisine, :is_10_bis, :address, :max_delivery_time_in_minutes)
  end

  def find_restaurant(id)
    Restaurant.find(id)
  end
end
