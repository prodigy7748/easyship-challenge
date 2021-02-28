require 'rails_helper'

RSpec.describe ShipmentsController do
  it 'can get right tracking info' do
    shipment = FactoryBot.create(:shipment, 'slug': 'usps', 'tracking_number': '92748902711539543475379057')
    get :show, params: { company_id: shipment.company.id, id: shipment.id }
    tracking = AfterShip::V4::Tracking.get(shipment.slug, shipment.tracking_number)

    expect(tracking["data"]["tracking"]["tag"]).to  eq("Delivered")
    expect(tracking['data']['tracking']["checkpoints"].last["location"]).to  eq("CLIFTON HEIGHTS, PA, 19018")
    expect(tracking['data']['tracking']["checkpoints"].last["checkpoint_time"]).to  eq("2021-01-09T11:14:00")
  end
end