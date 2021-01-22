# frozen_string_literal: true

class ShipstationOrderSyncWorker
  include Sidekiq::Worker
  sidekiq_options queue: :shipstation_order_sync, retry: false

  def perform(order_id)
    order = Shipstation::Order.retrieve(order_id)
    open_status = ["awaiting_payment", "awaiting_shipment", "on_hold"]
    if open_status.include? order["orderStatus"]
      puts "app_log(INFO, #{order["orderNumber"]}): started checking ..."
      puts "app_log(INFO, #{order["orderNumber"]}): orderId = #{order["orderId"]}"
      puts "app_log(INFO, #{order["orderNumber"]}): orderStatus = #{order["orderStatus"]}"
      puts "app_log(INFO, #{order["orderNumber"]}): serviceCode = #{order["serviceCode"]}"
      custom_field1 = order["advancedOptions"]["customField1"]
      puts "app_log(INFO, #{order["orderNumber"]}): customField1 = #{custom_field1}"
      if custom_field1.nil?
        begin
          order_payload = MyLib::CustomShipstation.order_update_payload(order: order)
          res = Shipstation::Order.create(order_payload)
          puts "app_log(INFO, #{order["orderNumber"]}): updated orderId = #{res["orderId"]}"
          puts "app_log(INFO, #{order["orderNumber"]}): updated orderNumber = #{res["orderNumber"]}"
          puts "app_log(INFO, #{order["orderNumber"]}): updated customField1 = #{res["advancedOptions"]["customField1"]}"
        rescue => err
          puts "app_log(ERROR, #{order["orderNumber"]}): #{err.message}"
        end
      end
      puts "app_log(INFO, #{order["orderNumber"]}): done"
    end
  end
end
