class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.belongs_to :shipstation_order

      t.string :sku
      t.string :name
      t.jsonb :options
      t.integer :qty, null: false

      t.timestamps
    end
  end
end
