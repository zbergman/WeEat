class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render :json => {:reviews => Review.all }
  end

  def show
    render :json => { :review => Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id]) }
  end

  def new
    render :json => { :review => Review.new }
  end

  def create
    render :json => { :review => Review.create(reviews_params) }
  end

  def edit
    render :json => { :review => Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id]) }
  end

  def update
    review = Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id])

    if review
      review.update_attributes(reviews_params)
    end
  end

  def delete
    render :json => { :review => Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id]) }
  end

  def destroy
    review = Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id])

    if review
      review.destroy
    end
  end

  private
  def reviews_params
    review = params.require(:review).permit(:text, :reviewer_name, :rating)
    review[:restaurant_id] = params[:restaurant_id]
    return review
  end
end
