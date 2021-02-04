# frozen_string_literal: true

class ShipstationShippedOrderSyncWorker
  include Sidekiq::Worker
  sidekiq_options queue: :shipstation_shipped_order_sync, retry: false

  def perform(order_id)
    order = Shipstation::Order.retrieve(order_id)
    puts "app_ship_log(INFO, #{order["orderNumber"]}): started checking ..."
    puts "app_ship_log(INFO, #{order["orderNumber"]}): orderStatus = #{order["orderStatus"]}"
    if order["orderStatus"] == "shipped"
      # Insert shipstation order
      shipstation_order = ShipstationOrder.create(
        order_number: order["orderNumber"],
        order_status: order["orderStatus"],
        order_date: order["orderDate"],
        ship_date: order["shipDate"],
        ship_to: order["shipTo"]
      )
      # Create items
      order["items"].each { |item|
        shipstation_order.items.create(
          sku: item["sku"],
          name: item["name"],
          options: item["options"],
          quantity: item["quantity"]
        )
      }
      puts "app_ship_log(INFO, #{order["orderNumber"]}): done"
    end
  end
end