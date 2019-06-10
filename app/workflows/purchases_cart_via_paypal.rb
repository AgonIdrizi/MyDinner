class PurchasesCartViaPaypal < PurchasesCart
  attr_accessor :pay_pal_payment

  def update_order
  	# update order status to pending
  end

  def redirect_on_success_url
	pay_pal_payment.redirect_url
  end

  def payment_attributes
  	super.merge(payment_method: "paypal")
  end

  def purchase
  	@pay_pal_payment = PayPalPayment.new(payment: payment)
  	payment.update(response_id: pay_pal_payment.response_id)
  	payment.pending!
  end
end