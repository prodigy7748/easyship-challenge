FactoryBot.define do
  factory :shipment_item do
    association :shipment
    description { nil }
    weight  { nil }
  end
end 