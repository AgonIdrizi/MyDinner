class LineItemsController < ApplicationController
  before_action :set_order, only: [:create, :update, :destroy]
  def create
  	@line_item = @order.line_items.find_or_initialize_by(item_id: params[:line_item][:item_id].to_i)
    @item = @line_item.item
    @line_items = @order.line_items
  	@line_item.quantity =  @line_item.quantity == nil ? 
                            params[:line_item][:quantity].to_i : 
                            @line_item.quantity + params[:line_item][:quantity].to_i
	respond_to do |format|
	  if @line_item.save
      format.html { redirect_to root_path, notice: 'Successfully added to cart.'}
      format.js
	  else
	  	format.html { render action: 'new' }
	  end
	end
  	
  end

  def update
  	@line_item = @order.line_items.find_by(item_id: params[:line_item][:item_id])
    @item = @line_item.item
    @line_items = @order.line_items
  	respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to cart_path, notice: 'Successfully updated the order item.' }
        format.js
      else
        format.html { render action: 'edit' }
      end
    end

  	
  
  end

  def destroy
  	@line_item = @order.line_items.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path}
  	  format.js 
    end
  	@line_items = @order.line_items
  end

private
  def line_item_params
  	params.require(:line_item).permit(:quantity, :item_id)
  end

  def set_order
    @order = current_order
  end
end
