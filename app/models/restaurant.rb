# == Schema Information
#
# Table name: restaurants
#
#  id                           :bigint           not null, primary key
#  name                         :string(40)
#  cuisine                      :string(20)
#  rating                       :float
#  is_10_bis                    :boolean
#  address                      :string(60)
#  max_delivery_time_in_minutes :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class Restaurant < ApplicationRecord
  # Associations
  has_many :reviews

  after_initialize :calc_rating

  # Scopes
  scope :sorted, lambda { order("name ASC") }

  # Validations
  validates :name,
            :presence => true,
            :length => {:maximum => 40}
  validates :cuisine,
            :presence => true,
            :length => {:maximum => 20}
  validates :rating,
            :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 5}
  validates :address,
            :presence => true,
            :length => {:maximum => 60}
  validates :max_delivery_time_in_minutes,
            :numericality => {:greater_than_or_equal_to => 0}

  private
  def calc_rating
    reviews = self.reviews
    self.rating = !reviews.empty? ? (reviews.map{|r| r.rating}.inject{ |sum, e| sum += e } / reviews.size) : 0
  end
end
