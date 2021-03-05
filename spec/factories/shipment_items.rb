FactoryBot.define do
  factory :shipment_item do
    association :shipment
    description { Faker::Device.model_name }
    weight  { rand(1..1000) }
  end
end 