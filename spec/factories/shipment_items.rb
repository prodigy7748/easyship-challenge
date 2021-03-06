FactoryBot.define do
  factory :shipment_item do
    association :shipment
    description { Faker::Device.model_name }
    weight  { Faker::Number.decimal(l_digits: 2) }
  end
end 