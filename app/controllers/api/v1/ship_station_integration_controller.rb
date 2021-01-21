# frozen_string_literal: true

class Api::V1::ShipStationIntegrationController < ActionController::API
  skip_before_action :verify_authenticity_token, raise: false

  def handle_new_order
    resource_type = params[:resource_type]
    resource_url = params[:resource_url]

    puts "app_log(INFO): resource_type = #{resource_type}"
    puts "app_log(INFO): resource_url = #{resource_url}"

    begin
      resource = resource_url.split("shipstation.com/")[1]
      puts "app_log(INFO): resource = #{resource}"
      new_orders = Shipstation.request(:get, resource)
      new_orders["orders"].each { |order|
        ShipstationOrdersSyncWorker.perform_in(Rails.configuration.shipstation[:delay].minutes, order["orderId"])
      }
    rescue => err
      puts "app_log(ERROR): #{err.message}"
    end

    render json: {
      status: true
    }
  end
end
