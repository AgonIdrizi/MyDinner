class PayPalPaymentsController < ApplicationController
	before_action :authenticate_user!
  def approved
  	order = Order.where(user_id: current_user.id).last
  	worklfow = ExecutesPayPalPayment.new(
		order: order,
  		payment_id: params[:paymentId],
  		token: params[:token],
  		payer_id: params[:PayerID])
	  worklfow.run
	  session[:order_id] = nil
  	redirect_to order || payment_path(id: worklfow.payment.reference)
  end
end
