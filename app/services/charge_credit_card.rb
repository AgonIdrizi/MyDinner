class ChargeCreditCard
  require "active_merchant/billing/rails"
  def initialize(amount, token)
  	@amount = amount
  	@token = token
  	@transaction
  end


  def processed
    @transaction = GATEWAY.purchase(@amount , @token)
    return false if !@transaction.success?   
    @transaction
  end

end