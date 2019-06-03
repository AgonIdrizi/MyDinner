class Cart < ApplicationRecord
  
  def self.clear_cart order
  	line_items = order.line_items
  	line_items.each do |line_item|
  	  line_item.delete
  	end
  end
end
