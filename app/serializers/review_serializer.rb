class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :restaurant_id, :restaurant_name, :reviewer_name, :rating, :text
  # belongs_to :restaurant

  def restaurant_name
    self.object.restaurant.name
  end
end
