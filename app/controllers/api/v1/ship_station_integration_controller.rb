# frozen_string_literal: true

class Api::V1::ShipStationIntegrationController < ActionController::API
  skip_before_action :verify_authenticity_token, raise: false

  def handle_new_order
    puts response.body
    resource_type = params[:resource_type]
    resource_url = params[:resource_url]

    puts "app_log(INFO): resource_type = #{resource_type}"
    puts "app_log(INFO): resource_url = #{resource_url}"
  end
end
