class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_order_isnt_empty, only: :new
  def new
  	@checkoutform = CheckoutForm.new
  end

  def create
  	@order = current_order
  	@checkoutform = CheckoutForm.new(@order,checkout_params)

  	if @checkoutform.save
  	  flash[:success] = 'Order was succesfully placed'
  	  session[:order_id] = nil
  	  redirect_to payments_path
  	else
  	  flash.now[:danger] = @checkoutform.errors.full_messages.to_s
  	  render 'new'
  	end
  	#change_order_status_to_ordered
  	#send_email_to_user_for_order_creation

  end

  private
  def ensure_order_isnt_empty
  	if current_order.line_items.empty?
  	  redirect_to root_path, notice: 'Your cart is empty, please add items to your cart'
  	end
  end

  def checkout_params
  	params.require(:checkout_form).permit(:email, :line1, :state, :city, :postal_code)
  end
end
