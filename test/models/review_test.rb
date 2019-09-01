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

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
