class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :cuisine, :is_10_bis, :address, :max_delivery_time_in_minutes, :rating
  has_many :reviews

  def rating
    self.object.calc_rating
  end
end