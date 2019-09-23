class AddRestaurantToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :restaurant, foreign_key: true, index:true
  end
end
