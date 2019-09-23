class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
