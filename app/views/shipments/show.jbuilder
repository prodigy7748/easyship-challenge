json.shipment do
  json.company_id           @shipment.company.uuid
  json.destination_country  @shipment.destination_country
  json.origin_country       @shipment.origin_country
  json.tracking_number      @shipment.tracking_number
  json.slug                 @shipment.slug
  json.created_at           @shipment.created_at.strftime('%A, %d %B %Y at%l:%M %p')
  json.items                @shipment.group_shipment_items
end