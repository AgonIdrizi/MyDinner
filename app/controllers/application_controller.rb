class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_order
  helper_method :get_current_user
  def current_order
  	if !session[:order_id].nil?
  	  Order.find(session[:order_id])
  	else
  	  create_order_based_on_user_existence
  	end
  end

  def create_order_based_on_user_existence

    order = Order.create
    session[:order_id] = order.id
    order
  end
  #this method helps initialize default attributes for unauthenticated users
  def get_current_user(email='', first_name='', last_name='')
    current_user.present? ? current_user : {user_id: nil, email: email, first_name: first_name, last_name: last_name}
  end
end
