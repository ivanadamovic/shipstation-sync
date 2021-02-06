# frozen_string_literal: true

class Api::V1::ShipStationIntegrationController < ActionController::API
  skip_before_action :verify_authenticity_token, raise: false

  def handle_new_order
    resource_type = params[:resource_type]
    resource_url = params[:resource_url]

    puts "app_log(INFO): resource_type = #{resource_type}"
    puts "app_log(INFO): resource_url = #{resource_url}"

    begin
      orders = MyLib::CustomShipstation.orders(resource_url: resource_url)
      orders.each { |order|
        ShipstationOrderSyncWorker.perform_in(Rails.configuration.shipstation[:delay].minutes, order["orderId"])
      }
    rescue => err
      puts "app_log(ERROR): #{err.message}"
    end

    render json: {
      status: true
    }
  end

  # Handle new shipped order
  def handle_new_shipped_order
    resource_type = params[:resource_type]
    resource_url = params[:resource_url]

    puts "app_log(INFO): resource_type = #{resource_type}"
    puts "app_log(INFO): resource_url = #{resource_url}"

    begin
      shipments = MyLib::CustomShipstation.shipments(resource_url: resource_url)
      shipments.each { |shipment|
        ShipstationShippedOrderSyncWorker.perform_in(Rails.configuration.shipstation[:delay].minutes, shipment["orderId"])
      }
    rescue => err
      puts "app_log(ERROR): #{err.message}"
    end

    render json: {
      status: true
    }
  end
end
