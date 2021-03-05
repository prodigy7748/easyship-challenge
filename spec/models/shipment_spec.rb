require "rails_helper"

RSpec.describe Shipment, type: :model do
  let(:shipment) {FactoryBot.create(:shipment)}

  context "group_shipment_items" do
    it 'should return grouped shipment_items in order of count' do
      FactoryBot.create_list(:shipment_item, 1, description: 'Apple Watch', shipment_id: shipment.id)
      FactoryBot.create_list(:shipment_item, 2, description: 'iPhone', shipment_id: shipment.id)
      FactoryBot.create_list(:shipment_item, 3, description: 'iPad', shipment_id: shipment.id)

      expect(shipment.group_shipment_items).to eq([
        { description: 'iPad', count: 3 },
        { description: 'iPhone', count: 2 },
        { description: 'Apple Watch', count: 1 }
      ])
    end
  end

  context "associations" do
    it { should belong_to(:company) }
    it { should have_many(:shipment_items) }
  end

  context "validations" do
    it { should validate_presence_of(:destination_country) }
    it { should validate_presence_of(:origin_country) }
    it { should validate_presence_of(:tracking_number) }
    it { should validate_presence_of(:slug) }
  end

end
