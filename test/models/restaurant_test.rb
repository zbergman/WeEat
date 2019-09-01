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

require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
