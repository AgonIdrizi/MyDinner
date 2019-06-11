class PayPalPaymentsController < ApplicationController
	before_action :authenticate_user!
  def approved
  	order = Order.where(user_id: current_user.id).last
  	worklfow = ExecutesPayPalPayment.new(
  		payment_id: params[:paymentId],
  		token: params[:token],
  		payer_id: params[:PayerID])
  	worklfow.run
  	redirect_to order || payment_path(id: worklfow.payment.reference)
  end
end
