class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :authorization_acces_only_your_orders, only: [:show]
  def show

  end

  #put items of your last-order, in current-cart
  def last_order
    
    @last_order = LastOrder.new(params[:order][:last_order_id].to_i, current_order).save
    if @last_order
      redirect_to cart_path
    end
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
