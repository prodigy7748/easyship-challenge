FactoryBot.define do
  factory :shipment do
    association :company
    destination_country { Faker::Address.country }
    origin_country  { Faker::Address.country }
    tracking_number  { "92748902711539543475379057" }
    slug { "usps" }
  end
end