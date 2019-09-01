# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]

  def index
    serialized_restaurants = ActiveModel::SerializableResource.new(Restaurant.sorted_by_name, each_serializer: RestaurantSerializer)
    render json: { restaurants: serialized_restaurants }
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
    @restaurant.update_attributes(restaurants_params)
  end

  def destroy
    @restaurant.destroy
  end

  private

  def restaurants_params
    params.require(:restaurant).permit(:name, :cuisine, :is_10_bis, :address, :max_delivery_time_in_minutes)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
