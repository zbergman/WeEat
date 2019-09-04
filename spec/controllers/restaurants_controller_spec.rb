require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  describe "actions" do
    describe "GET index" do
      let!(:restaurants) do
        FactoryBot.create_list(:restaurant, 2)
      end

      before(:each) do
        get(:index)
      end

      it "checking that 2 restaurants were created" do
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

      it "checking show" do
        get(:show, params: {:id => restaurant[:id]})
        expect(JSON.parse(response.body)).to eq(YAML.load(RestaurantSerializer.new(restaurant).to_json))
      end
    end

    describe "POST create" do
      before(:each) do
        post(:create, params: {:restaurant => {:name => "Soho", :cuisine => "Asian", :address => "Rishon", :max_delivery_time_in_minutes => 80}})
      end

      it "checking name" do
        expect(JSON.parse(response.body)["name"]).to eq("Soho")
      end

      it "checking cuisine" do
        expect(JSON.parse(response.body)["cuisine"]).to eq("Asian")
      end

      it "checking address" do
        expect(JSON.parse(response.body)["address"]).to eq("Rishon")
      end

      it "checking max_delivery_time_in_minutes" do
        expect(JSON.parse(response.body)["max_delivery_time_in_minutes"]).to eq(80)
      end
    end

    describe "PATCH update" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant, name: "Bergman's")
      end

      before(:each) do
        patch(:update, params: {:id => restaurant[:id], :restaurant => {:name => "Zohar's"}})
      end

      it "checking name" do
        get(:show, params: {:id => restaurant[:id]})
        expect(JSON.parse(response.body)["name"]).to eq("Zohar's")
      end
    end

    describe "PUT update" do
      let!(:restaurant) do
        FactoryBot.create(:restaurant, name: "Bergman's")
      end

      before(:each) do
        put(:update, params: {:id => restaurant[:id], :restaurant => {:name => "Zohar's"}})
      end

      it "checking name" do
        get(:show, params: {:id => restaurant[:id]})
        expect(JSON.parse(response.body)["name"]).to eq("Zohar's")
      end
    end

    describe "DELETE destroy" do
      before(:each) do
        @restaurant_one = FactoryBot.create(:restaurant)
        @restaurant_two = FactoryBot.create(:restaurant)
      end

      it "delete restaurant" do
        get(:index)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to match_array([YAML.load(RestaurantSerializer.new(@restaurant_one).to_json), YAML.load(RestaurantSerializer.new(@restaurant_two).to_json)])

        delete(:destroy, params: {:id => @restaurant_one[:id]})

        get(:index)
        expect(JSON.parse(response.body)).to eq([YAML.load(RestaurantSerializer.new(@restaurant_two).to_json)])
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end
  end
end
