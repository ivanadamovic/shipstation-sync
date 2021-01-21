# frozen_string_literal: true

class ShopifyOrdersSyncWorker
  include Sidekiq::Worker
  sidekiq_options queue: :shopify_orders_sync, retry: false

  def perform(order_id)
    order = Shipstation::Order.retrieve(order_id)
    open_status = ["awaiting_payment", "awaiting_shipment", "on_hold"]
    if open_status.include? order["orderStatus"]
      puts "app_log(INFO): checking order #{order["orderNumber"]} ..."
      puts "app_log(INFO): order id = #{order["orderId"]}"
      puts "app_log(INFO): order status = #{order["orderStatus"]}"
      puts "app_log(INFO): order customField1 = #{order["advancedOptions"]["customField1"]}"
      begin
        order_payload = MyLib::CustomShipStation.order_update_payload(order: order)
        res = Shipstation::Order.create(order_payload)
        puts "app_log(INFO): updated order id = #{res["orderId"]}"
        puts "app_log(INFO): updated order number = #{res["orderNumber"]}"
        puts "app_log(INFO): updated customField1 = #{res["advancedOptions"]["customField1"]}"
      rescue => err
        puts err.message
      end
      puts "app_log(INFO): done"
    end
  end
end
