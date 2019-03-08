class ChargeCreditCard
  require "active_merchant/billing/rails"
  attr_accessor :transaction
  def initialize(amount, token)
  	@amount = amount
  	@token = token
  	@transaction
  end


  def processed
    transaction = GATEWAY.purchase(@amount , @token)
    return false if !transaction.success?   
    @transaction = transaction
  end

end