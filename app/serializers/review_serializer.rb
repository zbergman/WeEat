# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_id, :restaurant_name, :reviewer_name, :rating, :text

  def restaurant_name
    object.restaurant.name
  end
end
