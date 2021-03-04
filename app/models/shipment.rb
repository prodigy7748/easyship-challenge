class Shipment < ApplicationRecord
  belongs_to :company
  has_many :shipment_items

  def group_shipment_items
    shipment_items.group(:description).order("count_all DESC").count.map{ |item, quantity| {description: item, count: quantity} }
  end
end
