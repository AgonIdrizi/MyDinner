class LastOrder
  attr_accessor :last_order, :current_order
  def initialize(last_order_id, current_order)
  	@last_order = Order.find_by(id: last_order_id)
  	@current_order = current_order
  end

  def save
  	transfer_line_items_to_current_order
  end

  def transfer_line_items_to_current_order
  	@last_order.line_items.each do |line_item|
  	  find_update_or_create_line_items(line_item)
  	end
  end

  def find_update_or_create_line_items(line_item)
  	@line_item = @current_order.line_items.find_or_initialize_by(item_id: line_item.item_id)
  	if @line_item.quantity == nil
	  @line_item.quantity = 1
	else
	  @line_item.quantity += line_item.quantity
	end
	@line_item.save
  end


private
  def find_last_order(last_order_id)
  	Order.find_by(id: last_order_id)
  end
end