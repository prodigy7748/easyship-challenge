FactoryBot.define do
  factory :shipment do
    association :company
    destination_country { Faker::Address.country }
    origin_country  { Faker::Address.country }
    tracking_number  { "UM459056399US" }
    slug { "usps" }
  end
end