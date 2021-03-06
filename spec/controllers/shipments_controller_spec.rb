require 'rails_helper'

RSpec.describe ShipmentsController do
  render_views
  let(:json) { JSON.parse(response.body) }
  let(:shipment) { FactoryBot.create(:shipment) }

  context "routes" do
    it { should route(:get, 'companies/1/shipments').to(action: :index, company_id: 1) }
    it { should route(:get, 'companies/1/shipments/1').to(action: :show, company_id: 1, id: 1) }
  end

  context "before_action" do
    it { should use_before_action(:find_company) }
  end

  describe "get #show" do
    before do
      FactoryBot.create_list(:shipment_item, 1, description: 'Apple Watch', shipment_id: shipment.id)
      FactoryBot.create_list(:shipment_item, 2, description: 'iPhone', shipment_id: shipment.id)
      FactoryBot.create_list(:shipment_item, 3, description: 'iPad', shipment_id: shipment.id)
    end

    context "if tracking info is available" do   
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
              "last_checkpoint_time": "2021-01-09T11:14:00"
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

  describe "get #index" do
    let(:company){ FactoryBot.create(:company) }
    let(:shipment){ FactoryBot.create(:shipment, company: company) }
    before do
      FactoryBot.create(:shipment_item, shipment: shipment, description: "IPhone", weight: 100.00)
    end

    it "should get shipments only belong to specific company with a right json format" do
      get :index, params: { company_id: company.id }, as: :json
      expect(json).to eq([
        {
        "company_name": shipment.company_name,
        "origin_country": shipment.origin_country,
        "destination_country": shipment.destination_country,
        "tracking_number": shipment.tracking_number,
        "items":[
          {
            "description": "IPhone",
            "weight": 100.00
          }
        ]
      }.with_indifferent_access])
    end
  end
end