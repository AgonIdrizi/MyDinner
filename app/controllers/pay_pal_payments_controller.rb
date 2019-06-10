class PayPalPaymentsController < ApplicationController
  def approved
  	order = Order.find_by(id: session[:order_id_for_payment])
  	worklfow = ExecutesPayPalPayment.new(
  		payment_id: params[:paymentId],
  		token: params[:token],
  		payer_id: params[:PayerID])
  	worklfow.run
  	redirect_to order || payment_path(id: worklfow.payment.reference)
  end
end
