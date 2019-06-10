class PurchasesCartViaSecurion < PurchasesCart
  attr_accessor :securion_token, :securion_charge

  def initialize(user:, securion_token:, purchase_amount_cents:)
  	super(user: user, purchase_amount_cents: purchase_amount_cents)
  	@securion_token = securion_token
  end

  def update_order
  end

  def purchase
  	@securion_charge = ChargeCreditCard.new(1000, securion_token)
  	if @securion_charge.processed
  	  payment.update!(status: 1, response_id: @securion_charge.transaction.params["id"])
  	else
  	  payment.update!(status: 3)
  	end
  end
end