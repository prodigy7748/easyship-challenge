class ShipmentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @shipments = Shipment.all
  end

  def show
    @company = Company.find_by!(id: params[:company_id])
    @shipment = @company.shipments.find_by!(id: params[:id])
  end

  def not_found
    render json: { error: error.message }, status: 404
  end

end
