class CreateShipstationOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :shipstation_orders do |t|
      t.string :order_number, null: false
      t.string :order_status, null: false
      t.datetime :order_date, null: false
      t.datetime :ship_date, null: false
      t.jsonb :ship_to, null: false

      t.timestamps
    end
  end
end
