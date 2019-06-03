class CartsController < ApplicationController
  def show
  	@item = Item.find_by(id: params[:id])
  	@line_items = current_order.line_items
  end

  def destroy
  	@order = current_order
  	Cart.clear_cart @order
  	redirect_to root_path , notice: 'Cart is cleared'
  end
end
