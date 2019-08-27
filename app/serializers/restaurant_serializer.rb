class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :cuisine, :is_10_bis, :rating, :address, :max_delivery_time_in_minutes
  has_many :reviews

  def rating
    self.object.calc_rating
  end
end