class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_order

  def current_order
  	if !session[:order_id].nil?
  	  Order.find(session[:order_id])
  	else
  	  create_order_based_on_user_existence
  	end
  end

  def create_order_based_on_user_existence
    order = !current_user.nil? ?  current_user.orders.create! : Order.create!
    session[:order_id] = order.id
    order
  end
end
