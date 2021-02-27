class Shipment < ApplicationRecord
  belongs_to :company
  has_many :shipment_items

  def group_shipment_items
    
  end
end
