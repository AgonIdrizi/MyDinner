class CreateRestaurantItem < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants_items do |t|
      t.references :restaurant, foreign_key: true
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
