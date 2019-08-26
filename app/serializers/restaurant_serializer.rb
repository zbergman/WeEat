class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :cuisine, :is_10_bis, :address, :max_delivery_time_in_minutes, :rating
  has_many :reviews

  def rating
    self.object.reviews.empty? ? 0 : (self.object.reviews.map{|r| r.rating}.inject{ |sum, e| sum += e } / self.object.reviews.size)
  end
end