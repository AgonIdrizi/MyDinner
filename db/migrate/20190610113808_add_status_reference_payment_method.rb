class AddStatusReferencePaymentMethod < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :status, :integer
  	add_column :payments, :reference, :string
  	add_column :payments, :payment_method, :string
  end
end
