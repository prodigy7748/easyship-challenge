class Shipment < ApplicationRecord
  belongs_to :company
  has_many :shipment_items

  delegate :name, to: :company, prefix: true

  validates :destination_country, presence: true
  validates :origin_country,      presence: true
  validates :tracking_number,     presence: true
  validates :slug,                presence: true

  def group_shipment_items
    shipment_items.group(:description).order("count_all DESC").count.map{ |item, quantity| {description: item, count: quantity} }
  end
end
