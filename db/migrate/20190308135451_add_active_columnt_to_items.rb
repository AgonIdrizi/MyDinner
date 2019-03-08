class AddActiveColumntToItems < ActiveRecord::Migration[5.2]
	class Item < ApplicationRecord
	end
  def change
    add_column :items, :active, :boolean, default: true

    reversible do |dir|
      Item.reset_column_information
      Item.find_each do |item|
        dir.up do
          item.update(active: true)
        end
      end
    end
  end
end
