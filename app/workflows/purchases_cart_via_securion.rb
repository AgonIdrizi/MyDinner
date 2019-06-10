class PurchaseCartViaSecurion < PurchasesCart
  attr_accessor :securion_token, :securion_charge

  def initialize(user:, securion_token:, purchases_amount_cents:)
  	super(user: user, purchases_amount_cents: purchases_amount_cents)
  	@securion_token = securion_token
  end

  def update_order
  end

  def purchase
  	@securion_charge = ChargeCreditCard.new(1000, securion token)
  	payment.update!(status: @securion_charge.status, response_id: @securion_charge.transaction.authorization)
  end
end