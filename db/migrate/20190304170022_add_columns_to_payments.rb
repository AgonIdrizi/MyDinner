class AddColumnsToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :first_name, :string
    add_column :payments, :last_name, :string
    add_column :payments, :last4, :string
    add_column :payments, :amount, :decimal, precision: 12, scale: 3
    add_column :payments, :success, :boolean
    add_column :payments, :authorization_code, :string
    add_reference :payments, :order, foreign_key: true
  end
end
