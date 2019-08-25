class RestaurantsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render :json => { :restaurants => Restaurant.all }
  end

  def show
    render :json => { :restaurant => Restaurant.find(params[:id]) }
  end

  def new
    render :json => { :restaurant => Restaurant.new }
  end

  def create
    render :json => { :restaurant => Restaurant.create(restaurants_params) }
  end

  def edit
    render :json => { :restaurant => Restaurant.find(params[:id]) }
  end

  def update
    restaurant = Restaurant.find(params[:id])

    if restaurant
      restaurant.update_attributes(restaurants_params)
    end
  end

  def delete
    render :json => { :restaurant => Restaurant.find(params[:id]) }
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
