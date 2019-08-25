require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "associations" do
    it { should belong_to(:restaurant) }
  end

  describe "check scope" do
    let!(:reviews) do
      restaurant = FactoryBot.create(:restaurant)
      [FactoryBot.create(:review, restaurant_id: restaurant[:id]), FactoryBot.create(:review, restaurant_id: restaurant[:id])].sort{ |r1, r2| r2.created_at <=> r1.created_at }
    end

    it "check sorted scope" do
      expect(Review.sorted).to match(reviews)
    end
  end
end
