# frozen_string_literal: true

class OrdersController < ApplicationController
  def show
    @order_number = 235400
    ship_to = {
      "city": "SAN ANTONIO",
      "name": "Mark Ralls",
      "phone": "(210) 394-4100",
      "state": "TX",
      "company": "",
      "country": "US",
      "street1": "118 LARAMIE DR",
      "street2": "",
      "street3": nil,
      "postalCode": "78209-2344",
      "residential": true,
      "addressVerified": "Address validated successfully"
    }
    @user_name = ship_to[:name]
    @street = ship_to[:street1] + " " + ship_to[:street2]
    @address = ship_to[:city] + ", " + [ship_to[:state], ship_to[:postalCode], ship_to[:country]].join(" ")
    @phone_number = ship_to[:phone]

    @order_date = "2/10/2021"

    shipment_items = {
      "sku": "CAF-007-05-OK",
      "name": "Centerville Amish Heavy Duty 700 Lb Roll Back Treated Porch Swing",
      "quantity": 1,
      "options": [
        {
          "name": "Select Length",
          "value": "5 Foot"
        },
        {
          "name": "Select Color",
          # "value": "Oak Stain (Ships in 5-7 Bus. Days)"
          "value": "Oak Stain"
        },
        {
          "name": "Add Optional Cupholder Armrests",
          "value": "With Cupholder Arms"
        },
        {
          "name": "Hanging Chains or Hanging Ropes",
          "value": "Hanging Chains Up To A 8 Ft. Ceiling"
        },
        {
          "name": "Add Optional Hardware",
          "value": "Without Comfort Springs & Hanging Hooks"
        },
        {
          "name": "_mw_option_relation",
          "value": "31994378813579_1612995111444"
        }
      ]
    }

    options = []
    shipment_items[:options].each do |shipment_item|
      if shipment_item[:name].exclude?("_mw_option_") && shipment_item[:value]&.downcase&.exclude?("without")
        value = shipment_item[:value]
        # if value.include?("(Ships in") && value.include?("Bus.Days")
        #   position = value.index(/(Ships in/)
        # end
        options << {
          "name": shipment_item[:name],
          "value": value
        }
      end
    end

    @shipment_items = [{
      "sku": "CAF-007-05-OK",
      "name": "Centerville Amish Heavy Duty 700 Lb Roll Back Treated Porch Swing",
      "quantity": 1,
      "options": options
    }]
  end

  # Get orders
  def index
    orders = ShipstationOrder.select(:id, :order_number, :ship_date)

    render json: {
      orders: orders
    }, status: :ok
  end
end
