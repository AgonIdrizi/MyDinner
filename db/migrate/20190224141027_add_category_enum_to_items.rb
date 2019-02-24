class AddCategoryEnumToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category, :string
    add_column :items, :item_category_type, :integer
  end
end
