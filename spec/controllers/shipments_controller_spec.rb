require 'rails_helper'

RSpec.describe ShipmentsController do
  render_views
  let(:json) { JSON.parse(response.body) }
  let(:shipment) { FactoryBot.create(:shipment) }

  describe "get #show" do
    before do
      FactoryBot.create_list(:shipment_item, 1, description: 'Apple Watch', shipment_id: shipment.id)
      FactoryBot.create_list(:shipment_item, 2, description: 'iPhone', shipment_id: shipment.id)
      FactoryBot.create_list(:shipment_item, 3, description: 'iPad', shipment_id: shipment.id)
    end

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
          "items": shipment.group_shipment_items
        }
      }.with_indifferent_access)
    end
  end
end