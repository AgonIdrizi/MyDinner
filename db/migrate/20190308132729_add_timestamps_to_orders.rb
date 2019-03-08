class AddTimestampsToOrders < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :order_submitted_at, :datetime, default: nil
  	add_column :orders, :order_completed_at, :datetime, default: nil
  	add_column :orders, :order_cancelled_at, :datetime, default: nil
  end
end
