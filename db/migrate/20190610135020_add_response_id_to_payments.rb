class AddResponseIdToPayments < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :response_id, :string
  end
end
