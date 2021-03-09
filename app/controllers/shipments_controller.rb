class ShipmentsController < ApplicationController
  before_action :find_company, only: [:index, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @shipments = @company.shipments
  end

  def show
    @shipment = @company.shipments.find(params[:id])
  end

  private
  def find_company
    @company = Company.find(params[:company_id])
  end

  def not_found
    render json: { error: error.message }, status: 404
  end

end
