class PurchasesCart
	attr_accessor :user, :purchases_amount_cents,
		:purchase_amount, :success,
		:payment
	
	def initialize(user: nil, purchases_amount_cents:nil)
	  @user = user
	  @purchase_amount = Money.new(purchases_amount_cents)
	  @success = false
	end

	def run
	  Payment.transaction do 
	  	update_order
	  	create_paymment
	  	purchase
	  	calculate_success
	  	
	  end
	end

	def calculate_success
	  @success = payment.succeeded?
	end
end