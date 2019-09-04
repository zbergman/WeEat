# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]

  def index
    render json: Review.sorted_by_created_at, each_serializer: ReviewSerializer
  end

  def show
    render json: @review, serializer: ReviewSerializer
  end

  def new
    render json: Review.new(restaurant_id: params[:restaurant_id]), serializer: ReviewSerializer
  end

  def create
    render json: Review.create(reviews_params), serializer: ReviewSerializer
  end

  def edit
    render json: @review, serializer: ReviewSerializer
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
