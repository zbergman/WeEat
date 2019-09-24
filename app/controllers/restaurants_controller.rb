# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]

  def index
    render json: Restaurant.sorted_by_name, each_serializer: RestaurantSerializer
  end

  def show
    render json: @restaurant, serializer: RestaurantSerializer
  end

  def new
    render json: Restaurant.new, serializer: RestaurantSerializer
  end

  def create
    render json: Restaurant.create(restaurants_params), serializer: RestaurantSerializer
  end

  def edit
    render json: RestaurantSerializer.new(@restaurant), serializer: RestaurantSerializer
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
