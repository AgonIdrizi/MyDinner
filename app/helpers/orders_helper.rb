module OrdersHelper
  def last_order_items
  	msg = ''
  	msg_no_order = content_tag(:p,'You still havent made any order')
  	if current_user.present?
  	  order = current_user.orders.where(status: 'paid').includes(:line_items).last || (return msg_no_order)
      button_to_msg = button_to('Add items to card', last_order_path, id: 'last-order', params: {'order[last_order_id]' => order})
  	    order.items.each do |item|
  	      msg <<"<p>#{item.name}, #{item.price}</p>".html_safe
  	    end
  	  content_tag(:p,msg.html_safe) + '<hr>'.html_safe + button_to_msg
  	else
  	  msg_no_order
  	end
  	
  end

end
