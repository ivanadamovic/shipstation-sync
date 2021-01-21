# frozen_string_literal: true

module MyLib
  class CustomShipStation
    class << self
      def orders(start_date:)
        # start_date = ""
        Shipstation::Order.list(
          orderDateStart: start_date, # 2021-01-20
          storeId: Rails.configuration.shipstation[:shopify_store_id]
        )
      end

      def order_update_payload(order:)
        advanced_options_new = order["advancedOptions"]
        advanced_options_new.delete "customField1"
        advanced_options_new["customField1"] = order["orderNumber"]

        order_new = order
        [
          "advancedOptions"
        ].each { |k| order_new.delete k }
        order_new["advancedOptions"] = advanced_options_new

        order_new
        end
    end
  end
end
