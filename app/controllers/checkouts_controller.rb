class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_order_isnt_empty, only: :new
  def new
  end

  def create
  	change_order_status_to_ordered
  	send_email_to_user_for_order_creation

  end

  private
  def ensure_order_isnt_empty
  	if current_order.line_items.empty?
  	  redirect_to root_path, notice: 'Your cart is empty, please add items to your cart'
  	end
  end
end
