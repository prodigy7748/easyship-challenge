class ShipmentsController < ApplicationController
  require 'aftership'

  def index
    @shipments = Shipment.all
  end

  def show
    @company = Company.find_by(id: params[:company_id])
    @shipment = @company.shipments.find_by(id: params[:id])
  end
end
