class RemoveColumnsFromItems < ActiveRecord::Migration[5.2]
  def change
  	remove_column :items, :item_category_type, :integer
  	remove_column :items, :category, :string
  end
end
