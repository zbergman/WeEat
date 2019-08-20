class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    Review.sorted
  end

  def show
    Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id])
  end

  def new
    Review.new
  end

  def create
    Review.create(reviews_params)
  end

  def edit
    Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id])
  end

  def update
    review = Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id])

    if review
      review.update_attributes(reviews_params)
    end
  end

  def delete
    Review.where(:restaurant_id => params[:restaurant_id]).find(params[:id])
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
