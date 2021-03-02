class Shipment < ApplicationRecord
  belongs_to :company
  has_many :shipment_items

  validates :destination_country, presence: true
  validates :origin_country,      presence: true
  validates :tracking_number,     presence: true
  validates :slug,                presence: true

  delegate :name, to: :company, prefix: true

  def group_shipment_items
    shipment_items.group(:description).count.sort_by{ |key, value| value }.reverse.map{ |item, quantity| {description: item, count: quantity} }
  end
end
