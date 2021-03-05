class ShipmentsController < ApplicationController
  require 'aftership'
  before_action :find_company, only: [:index, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @shipments = @company.shipments.includes(:shipment_items)
  end

  def show
    @shipment = @company.shipments.find_by!(id: params[:id])

    AfterShip.api_key = ENV['AFTERSHIP_API_KEY']
    @tracking = AfterShip::V4::Tracking.get(@shipment.slug, @shipment.tracking_number)
  end

  def not_found
    render json: { error: error.message }, status: 404
  end
  
  private

  def find_company
    @company = Company.find_by!(id: params[:company_id])
  end
end
