class Shipment < ApplicationRecord
  belongs_to :company
  has_many :shipment_items

  delegate :name, to: :company

  def group_shipment_items
    shipment_items.group(:description).count.sort_by{ |key, value| value }.reverse.map{ |item, quantity| {description: item, count: quantity} }
  end
end
