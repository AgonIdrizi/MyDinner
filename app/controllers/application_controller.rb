class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_order

  def current_order
  	if !session[:order_id].nil?
  	  Order.find(session[:order_id])
  	else
  	 order = Order.create!
  	  session[:order_id] = order.id
  	  order
  	end
  end
end
