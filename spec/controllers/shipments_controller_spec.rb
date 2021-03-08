require 'rails_helper'

RSpec.describe ShipmentsController do
  render_views
  let(:json) { JSON.parse(response.body) }
  before do
    FactoryBot.create_list(:shipment_item, 1, description: 'Apple Watch', shipment_id: shipment.id)
    FactoryBot.create_list(:shipment_item, 2, description: 'iPhone', shipment_id: shipment.id)
    FactoryBot.create_list(:shipment_item, 3, description: 'iPad', shipment_id: shipment.id)
  end

  describe "get #show" do

    context "if tracking info is available" do
      let(:shipment) { FactoryBot.create(:shipment) }
      
      it 'can get right json format' do
        get :show, params: { company_id: shipment.company.id, id: shipment.id }
        expect(response).to have_http_status(200)
        expect(json).to eq({
          "shipment": {
            "company_id": shipment.company.id,
            "destination_country": shipment.destination_country,
            "origin_country": shipment.origin_country,
            "tracking_number": shipment.tracking_number,
            "slug": shipment.slug,
            "created_at": shipment.created_at.strftime('%A, %d %B %Y at%l:%M %p'),
            "items": shipment.group_shipment_items,
            "tracking": {
              "status": "Delivered",
              "current_location": "CLIFTON HEIGHTS, PA, 19018",
              "last_checkpoint_message": "Delivered, In/At Mailbox",
              "last_checkpoint_time": "Saturday, 09 January 2021 at 12 AM"
            }
          }
        }.with_indifferent_access)
      end
    end

    context "if tracking info is not available yet" do
      let(:shipment) { FactoryBot.create(:shipment, "tracking_number": "fakenumber") }

      it "can get right json format" do
        get :show, params: { company_id: shipment.company.id, id: shipment.id }
        expect(json).to eq({
          "shipment": {
            "company_id": shipment.company.id,
            "destination_country": shipment.destination_country,
            "origin_country": shipment.origin_country,
            "tracking_number": shipment.tracking_number,
            "slug": shipment.slug,
            "created_at": shipment.created_at.strftime('%A, %d %B %Y at%l:%M %p'),
            "items": shipment.group_shipment_items,
            "tracking": "No tracking information yet."
          }
        }.with_indifferent_access)      
      end
    end
  end
end