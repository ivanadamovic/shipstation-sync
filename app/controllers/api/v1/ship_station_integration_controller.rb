# frozen_string_literal: true

class Api::V1::ShipStationIntegrationController < ActionController::API
  skip_before_action :verify_authenticity_token

  def handle_new_order
    data = JSON.parse(response.body)
    resource_type = data["resource_type"]
    resource_url = data["resource_url"]

    puts "app_log(INFO): resource_type = #{resource_type}"
    puts "app_log(INFO): resource_url = #{resource_url}"
  end
end
