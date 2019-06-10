class PayPalPayment
  attr_accessor :payment, :pay_pal_payment

  delegate :create, to: :pay_pal_payment
  delegate :execute, to: :pay_pal_payment

  def self.find(payment_id)
  	PayPal::SDK::REST::Payment.find(payment_id)
  end

  def initialize(payment:)
  	@payment = payment
  	@pay_pal_payment = build_pay_pal_payment
  end

  def build_pay_pal_payment
  	PayPal::SDK::REST::Payment.new(
	  intent: “sale”, payer: {payment_method: “paypal”},
	  redirect_urls: redirect_info, transactions: [payment_info])
  end

  def host_name
  	ENV['host_name']
  end

  def redirect_info
	{return_url: "http://#{host_name}/paypal/approved",
	cancel_url: "http://#{host_name}/paypal/rejected"}
  end

  def payment_info
  	{item_list: {items: [{name: 'test', sku:'test_event_id',price: '10.00', currency: "USD", quantity: 1}]},
  	amount:{total: '10.00', currency: "USD"}}
  end

  def created?
	pay_pal_payment.state == “created”
  end

  def redirect_url
  	create unless created?	
  	pay_pal_payment.links.find { |link| link.method =="REDIRECT" }.href
  end

  def response_id
  	create unless created?
  	pay_pal_payment.id
  end

end