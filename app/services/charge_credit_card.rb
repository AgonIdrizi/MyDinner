class ChargeCreditCard
  require "active_merchant/billing/rails"
  def initialize(amount, params)
  	@amount = amount
  	@token = params[:token]
  	@transaction
  end


  def processed
    @transaction = GATEWAY.purchase(@amount , @token)
    return false if !@transaction.success?   
    @transaction
  end

end