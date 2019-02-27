class CartsController < ApplicationController
  def show
  	@order_items = current_order.line_items
  end
end
