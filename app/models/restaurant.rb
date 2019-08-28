# == Schema Information
#
# Table name: restaurants
#
#  id                           :bigint           not null, primary key
#  name                         :string(40)
#  cuisine                      :string(20)
#  is_10_bis                    :boolean
#  address                      :string(60)
#  max_delivery_time_in_minutes :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class Restaurant < ApplicationRecord
  # Accessors
  attr_accessor :rating

  # Associations
  has_many :reviews, dependent: :destroy

  # Scopes
  scope :sorted_by_name, lambda { order("name ASC") }

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 40}
  validates :cuisine,
            presence: true,
            length: {maximum: 20}
  validates :address,
            presence: true,
            length: {maximum: 60}
  validates :max_delivery_time_in_minutes,
            numericality: {greater_than_or_equal_to: 0}

  # def as_json(options = { })
  #   r = super(options)
  #   r[:rating] = calc_rating
  #   r
  # end

  def calc_rating
    reviews.empty? ? 0 : (reviews.map{|r| r.rating}.inject{ |sum, e| sum += e } / reviews.size)
  end
end
