class PurchasesCart
	attr_accessor :user, :purchases_amount_cents,
		:purchase_amount, :success,
		:payment
	
	def initialize(user: nil, purchases_amount_cents:nil)
	  @user = user
	  @purchase_amount = Money.new(1000)
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

	def redirect_on_success_url
	  nil
	end

	def create_payment
	  self.payment = Payment.create!(payment_attributes)
	  payment.create_line_items(tickets)
	end

	def payment_attributes
	  {user_id: 5, amounts: 1000,
	  	status: 'created', reference: Payment.generate_reference}
	end

	def success?
	  success
	end
end