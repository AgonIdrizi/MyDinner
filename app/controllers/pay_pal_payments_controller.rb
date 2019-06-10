class PayPalPaymentsController < ApplicationController
  def approved
  	worklfow = ExecutesPayPalPayment.new(
  		payment_id: params[:paymentId],
  		token: params[:token],
  		payer_id: params[:PayerID])
  	worklfow.run
  	redirect_to payment_path(id: worklfow.payment.reference)
  end
end
