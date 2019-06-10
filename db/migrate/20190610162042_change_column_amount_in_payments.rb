class ChangeColumnAmountInPayments < ActiveRecord::Migration[5.2]
  def change
  	change_column :payments, :amount, :integer
  end
end
