class ShipmentsController < ApplicationController

  require 'aftership'

  before_action :find_company, only: [:index, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::BadRequest, with: :raise_bad_request

  def index
    @shipments = @company.shipments
  end

  def show
    @shipment = @company.shipments.find(params[:id])

    AfterShip.api_key = ENV['AFTERSHIP_API_KEY']
    @tracking = AfterShip::V4::Tracking.get(@shipment.slug, @shipment.tracking_number)['data']['tracking']
  end

  private
  def find_company
    @company = Company.find(params[:company_id])
  end

  def not_found
    render json: { error: error.message }, status: 404
  end

  def raise_bad_request
    Rails.logger.error "API exception: #{e.message}"
  end
end
