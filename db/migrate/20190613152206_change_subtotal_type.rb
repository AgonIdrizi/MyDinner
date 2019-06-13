class ChangeSubtotalType < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :subtotal, :integer, default: 0
    change_column :orders, :tax, :integer,  default: 0
    change_column :orders, :total, :integer,  default: 0
  end
end
