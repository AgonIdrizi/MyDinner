class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :item, foreign_key: true
      t.references :order
      t.decimal :unit_price, precision: 12, scale: 3
      t.integer :quantity
      t.decimal :total_price, precision: 12, scale: 3

      t.timestamps
    end
  end
end
