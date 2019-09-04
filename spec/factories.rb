FactoryBot.define do
  factory :restaurant, class: Restaurant do
    name { Faker::Restaurant.name }
    cuisine { "Asian" }
    address { Faker::Address.city }
    max_delivery_time_in_minutes { Faker::Number.between(from: 10, to: 100) }
    is_10_bis { Faker::Boolean.boolean}
  end

  factory :review, class: Review do
    text { Faker::Restaurant.review}
    reviewer_name { Faker::Name.name }
    rating { Faker::Number.between(from: 1, to: 5) }
  end
end