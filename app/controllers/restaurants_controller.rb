class RestaurantsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    render json: {restaurants: ActiveModel::SerializableResource.new(Restaurant.sorted_by_name, each_serializer: RestaurantSerializer) }
  end

  def show
    render json: { restaurant: RestaurantSerializer.new(@restaurant) }
  end

  def new
    render json: { restaurant: RestaurantSerializer.new(Restaurant.new) }
  end

  def create
    render json: { restaurant: RestaurantSerializer.new(Restaurant.create(restaurants_params)) }
  end

  def edit
    render json: { restaurant: RestaurantSerializer.new(@restaurant) }
  end

  def update
    @restaurant.update_attributes(restaurants_params) if @restaurant
  end

  def destroy
    if @restaurant
      @restaurant.reviews.each{|review| review.destroy }
      @restaurant.destroy
    end
  end

  private
  def restaurants_params
    params.require(:restaurant).permit(:name, :cuisine, :is_10_bis, :address, :max_delivery_time_in_minutes)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
