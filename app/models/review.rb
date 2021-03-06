# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id            :bigint           not null, primary key
#  text          :text
#  reviewer_name :string(40)
#  rating        :integer
#  restaurant_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Review < ApplicationRecord
  # Associations
  belongs_to :restaurant, foreign_key: :restaurant_id

  # Scopes
  scope :sorted_by_created_at, -> { order(created_at: :desc) }

  # Validations
  validates :text,
            presence: true
  validates :reviewer_name,
            presence: true,
            length: { maximum: 40 }
  validates :rating,
            presence: true,
            numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 1 }
  validates :restaurant_id,
            presence: true
end
