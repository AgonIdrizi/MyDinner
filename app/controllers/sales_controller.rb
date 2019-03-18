class SalesController < ApplicationController
  def sales
  	@line_item = current_order.line_items.new
  	@items = all_active_sales
  	render 'items/index'
  end
end
