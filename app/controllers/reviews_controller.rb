class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { reviews: Review.sorted_by_created_at.map{ |review| ReviewSerializer.new(review)} }
  end

  def show
    render json: { review: ReviewSerializer.new(find_review(params[:id], params[:restaurant_id])) }
  end

  def new
    render json: { review: ReviewSerializer.new(Review.new(restaurant_id: params[:restaurant_id])) }
  end

  def create
    render json: { review: ReviewSerializer.new(Review.new(Review.create(reviews_params))) }
  end

  def edit
    render json: { review: ReviewSerializer.new(find_review(params[:id], params[:restaurant_id])) }
  end

  def update
    review = find_review(params[:id], params[:restaurant_id])
    review.update_attributes(reviews_params) if review
  end

  def destroy
    review = find_review(params[:id], params[:restaurant_id])
    review.destroy if review
  end

  private
  def reviews_params
    review = params.require(:review).permit(:text, :reviewer_name, :rating)
    review[:restaurant_id] = params[:restaurant_id]
    review
  end

  def find_review(id, restaurant_id)
    Review.where(restaurant_id: restaurant_id).find(id)
  end
end
