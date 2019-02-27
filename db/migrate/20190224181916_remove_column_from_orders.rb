class RemoveColumnFromOrders < ActiveRecord::Migration[5.2]
  def change
  	remove_column :orders, :order_status_id, :integer
  	add_column :orders, :status, :string
  	add_column :orders, :order_status_type, :integer
  end
end
