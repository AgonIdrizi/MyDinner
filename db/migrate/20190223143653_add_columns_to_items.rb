class AddColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :name, :string, null: false
    add_column :items, :description, :text, null: false
    add_column :items, :price_cents, :integer
    add_column :items, :currency, :string
    add_index :items, :name
  end
end
