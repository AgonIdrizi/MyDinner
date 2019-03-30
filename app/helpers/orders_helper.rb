module OrdersHelper
  def last_order_items
  	msg = ''
  	
  	if current_user.present?
  	  order = current_user.orders.where(status: 'paid').includes(:items).last
      button_to_msg = button_to('Add items to card', last_order_path, params: {'order[last_order_id]' => order})
  	    order.items.each do |item|
  	      msg <<"#{item.name}, #{item.price}"
  	    end
  	  content_tag(:p,msg.html_safe) + '<hr>'.html_safe + button_to_msg
  	else
  	  content_tag(:p,'You still havent made any order')
  	end
  	
  end

end
