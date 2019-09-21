class PurchasesCartViaSecurion < PurchasesCart
	
	attr_accessor :user, :securion_token, :securion_charge

  def initialize(user:,order:, securion_token:, purchase_amount_cents:)
  	super(user: user,order: order, purchase_amount_cents: purchase_amount_cents)
  	@securion_token = securion_token
  end

  def update_order
	UpdateOrderStatusAfterChargeWorker.perform_async(order.id)
	EmailConfirmationForSuccesfullPaymentWorker.perform_async(order.id, @user)
  end

  def purchase
  	@securion_charge = ChargeCreditCard.new(1000, securion_token)
  	if @securion_charge.processed
	  payment.update!(status: 1,success: true, 
			order_id: order.id, last4:@securion_charge.transaction.params['last4'],
			payment_method: 'card', response_id: @securion_charge.transaction.params['id'])
  	else
  	  payment.update!(status: 3)
  	end
  end
end