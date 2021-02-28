class ShipmentsController < ApplicationController
  require 'aftership'

  def index
    @shipments = Shipment.all
  end

  def show
    @company = Company.find_by(id: params[:company_id])
    @shipment = @company.shipments.find_by(id: params[:id])

    AfterShip.api_key = ENV['AFTERSHIP_API_KEY']
    @tracking = AfterShip::V4::Tracking.get(@shipment.slug, @shipment.tracking_number)
  end
end
