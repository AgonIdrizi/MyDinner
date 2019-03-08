class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :authorization_acces_only_your_orders
  def show

  end

private
  def set_order
  	@order = Order.includes(:line_items).find_by(id: params[:id])
  end

  def authorization_acces_only_your_orders
  	if @order.user_id != current_user.id
  	  flash[:danger] = 'Unauthorized'
  	  redirect_to root_path
  	end
  end
end
