class CreateItemCategoryTable < ActiveRecord::Migration[5.2]
  def change
    create_table :items_categories do |t|
      t.belongs_to :item, index: true
      t.belongs_to :category, index: true
    end
  end
end
