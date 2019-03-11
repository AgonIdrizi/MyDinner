class AddPreparationTimeToItems < ActiveRecord::Migration[5.2]
  class Item < ApplicationRecord
  end
  def change
    add_column :items, :preparation_time, :integer, default: 12

    reversible do |dir|
  	  Item.reset_column_information
  	  Item.find_each do |item|
  	    dir.up do
  	  	  item.update(preparation_time: 12)
  	    end
  	  end
    end
  end

  
end
