class CartsController < ApplicationController
  def show
  	@item = Item.find_by(id: params[:id])
  	@line_items = current_order.line_items
  end
end
