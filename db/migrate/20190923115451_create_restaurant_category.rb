class CreateRestaurantCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants_categories do |t|
      t.belongs_to :restaurant, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end
  end
end
