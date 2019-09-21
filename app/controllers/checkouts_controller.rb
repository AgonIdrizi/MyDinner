class CheckoutsController < ApplicationController
  #before_action :authenticate_user!
  before_action :ensure_order_isnt_empty
  
  def new
	@checkoutform = CheckoutForm.new(current_user)
  end

  def create
	@order = current_order
  	@checkoutform = CheckoutForm.new(@order,checkout_params, get_current_user[:id])
	  if @checkoutform.save
	  SendOrderConfirmationWorker.perform_async(@order.id, @checkoutform.email)
	  session[:email] = @checkoutform.email
	  session[:checkout] = true
      flash[:success] = 'Order was succesfully placed'
  	  redirect_to new_payment_path
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
