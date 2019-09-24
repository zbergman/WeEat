require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "actions" do
    describe "GET index" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant)
      end

      let!(:reviews) do
        [FactoryBot.create(:review, restaurant_id: restaurant[:id]),
         FactoryBot.create(:review, restaurant_id: restaurant[:id])]
      end

      before(:each) do
        get(:index, params: { restaurant_id: restaurant.id })
      end

      it "checking that 2 reviews were created" do
        expect(JSON.parse(response.body).size).to eq(2)
      end

      it "checking creation status" do
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant)
      end

      let!(:review) do
        FactoryBot.create(:review, restaurant_id: restaurant[:id])
      end

      it "checking show" do
        get(:show, params: {id: review[:id], restaurant_id: restaurant[:id]})
        expect(JSON.parse(response.body)).to eq(YAML.load(ReviewSerializer.new(review).to_json))
      end
    end

    describe "POST create" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant)
      end

      before(:each) do
        post(:create, params: {review: {text: "Nice place", reviewer_name: "Zohar", rating: 4}, restaurant_id: restaurant[:id]})
      end

      it "checking text" do
        expect(JSON.parse(response.body)["text"]).to eq("Nice place")
      end

      it "checking reviewer_name" do
        expect(JSON.parse(response.body)["reviewer_name"]).to eq("Zohar")
      end

      it "checking rating" do
        expect(JSON.parse(response.body)["rating"]).to eq(4)
      end

      it "checking restaurant_id" do
        expect(JSON.parse(response.body)["restaurant_id"]).to eq(restaurant[:id])
      end
    end

    describe "PATCH update" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant)
      end

      let!(:review) do
        FactoryBot.create(:review, restaurant_id: restaurant[:id], reviewer_name: "Zohar")
      end

      before(:each) do
        patch(:update, params: {id: review[:id], restaurant_id: restaurant[:id], review: {reviewer_name: "Yotam"}})
      end

      it "checking name" do
        get(:show, params: {id: review[:id], restaurant_id: restaurant[:id]})
        expect(JSON.parse(response.body)["reviewer_name"]).to eq("Yotam")
      end
    end

    describe "PUT update" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant)
      end

      let!(:review) do
        FactoryBot.create(:review, restaurant_id: restaurant[:id], reviewer_name: "Zohar")
      end

      before(:each) do
        put(:update, params: {id: review[:id], restaurant_id: restaurant[:id], review: {reviewer_name: "Yotam"}})
      end

      it "checking name" do
        get(:show, params: {id: review[:id], restaurant_id: restaurant[:id]})
        expect(JSON.parse(response.body)["reviewer_name"]).to eq("Yotam")
      end
    end

    describe "DELETE destroy" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant)
      end

      before(:each) do
        @review_one = FactoryBot.create(:review, restaurant_id: restaurant[:id])
        @review_two = FactoryBot.create(:review, restaurant_id: restaurant[:id])
      end

      it "delete review" do
        get(:index, params: { restaurant_id: restaurant.id })
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to match_array([YAML.load(ReviewSerializer.new(@review_one).to_json), YAML.load(ReviewSerializer.new(@review_two).to_json)])

        delete(:destroy, params: {:id => @review_one[:id], restaurant_id: restaurant[:id]})

        get(:index, params: { restaurant_id: restaurant.id })
        expect(JSON.parse(response.body)).to eq([YAML.load(ReviewSerializer.new(@review_two).to_json)])
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end
  end
end
