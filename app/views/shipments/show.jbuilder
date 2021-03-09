json.shipment do

  json.company_id           @shipment.company_id
  json.destination_country  @shipment.destination_country
  json.origin_country       @shipment.origin_country
  json.tracking_number      @shipment.tracking_number
  json.slug                 @shipment.slug
  json.created_at           @shipment.created_at.strftime('%A, %d %B %Y at%l:%M %p')
  json.items @shipment.group_shipment_items
  
  if @tracking['data']['tracking'].nil?
    json.tracking "No tracking information yet."
  else
    json.tracking do
    json.status                  @tracking['data']['tracking']["tag"]
    json.current_location        @tracking['data']['tracking']["checkpoints"].last["location"]
    json.last_checkpoint_message @tracking['data']['tracking']["checkpoints"].last["message"]
    json.last_checkpoint_time    Date.parse(@tracking['data']['tracking']["checkpoints"].last["checkpoint_time"]).strftime("%A, %d %B %Y at %l %p")
    end
  end
end