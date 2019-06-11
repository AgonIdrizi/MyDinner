class PurchasesCart
	attr_accessor :user,:order, :purchase_amount_cents,
		:purchase_amount, :success,
		:payment
	
	def initialize(user: nil,order:, purchase_amount_cents:nil)
	  @user = user
	  @order = order
	  @purchase_amount = Money.new(1000)
	  @success = false
	end

	def run
	  Payment.transaction do 
		create_payment
		purchase
		update_order
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
	  #payment.create_line_items(tickets)
	end

	def payment_attributes
	  {user_id: user.id, amount: 1000, first_name: user.first_name, last_name:user.last_name,
	  	status: 'created', reference: Payment.generate_reference}
	end

	def success?
	  success
	end
end