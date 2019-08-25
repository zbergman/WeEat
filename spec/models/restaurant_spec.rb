require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "associations" do
    it { should have_many(:reviews) }
  end

  describe "check scope" do
    let!(:restaurants) do
      [FactoryBot.create(:restaurant), FactoryBot.create(:restaurant)].sort_by{ |r| r.name }
    end

    it "check sorted scope" do
      expect(Restaurant.sorted).to match(restaurants)
    end
  end
end
