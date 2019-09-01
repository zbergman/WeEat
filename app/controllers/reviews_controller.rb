# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  def index
    serialized_reviews = ActiveModel::SerializableResource.new(Review.sorted_by_created_at, each_serializer: ReviewSerializer)
    render json: { reviews: serialized_reviews }
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
    @review.update_attributes(reviews_params)
  end

  def destroy
    @review.destroy
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
