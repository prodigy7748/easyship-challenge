class ShipmentsController < ApplicationController

  require 'aftership'

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @shipments = Shipment.all
  end

  def show
    @company = Company.find(params[:company_id])
    @shipment = @company.shipments.find(params[:id])

    AfterShip.api_key = ENV['AFTERSHIP_API_KEY']
    @tracking = AfterShip::V4::Tracking.get(@shipment.slug, @shipment.tracking_number)
  end

  def not_found
    render json: { error: error.message }, status: 404
  end

end
