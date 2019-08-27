class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    render json: {reviews: ActiveModel::SerializableResource.new(Review.sorted_by_created_at, each_serializer: ReviewSerializer) }
  end

  def show
    render json: { review: ReviewSerializer.new(@review) }
  end

  def new
    render json: { review: ReviewSerializer.new(Review.new(restaurant_id: params[:restaurant_id])) }
  end

  def create
    render json: { review: ReviewSerializer.new(Review.create(reviews_params)) }
  end

  def edit
    render json: { review: ReviewSerializer.new(@review) }
  end

  def update
    @review.update_attributes(reviews_params) if @review
  end

  def destroy
    @review.destroy if @review
  end

  private
  def reviews_params
    review = params.require(:review).permit(:text, :reviewer_name, :rating)
    review[:restaurant_id] = params[:restaurant_id]
    review
  end

  def set_review
    @review = Review.where(restaurant_id: params[:restaurant_id]).find(params[:id])
  end
end
