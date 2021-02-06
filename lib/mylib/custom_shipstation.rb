# frozen_string_literal: true

module MyLib
  class CustomShipstation
    class << self
      def order_update_payload(order:)
        advanced_options_new = order["advancedOptions"]
        advanced_options_new.delete "customField1"
        advanced_options_new["customField1"] = order["orderNumber"]

        order_new = order
        order_new.delete "advancedOptions"
        order_new["advancedOptions"] = advanced_options_new

        order_new
      end

      def resource(resource_url:)
        resource_url.split("shipstation.com/")[1]
      end

      def orders(resource_url:)
        _resource = resource(resource_url: resource_url)
        puts "app_log(INFO): resource = #{_resource}"
        Shipstation.request(:get, _resource)["orders"]
      end

      def shipments(resource_url:)
        _resource = resource(resource_url: resource_url)
        puts "app_log(INFO): resource = #{_resource}"
        Shipstation.request(:get, _resource)["shipments"]
      end
    end
  end
end
