class UpdatePaymentObjectAfterChargeWorker
  include Sidekiq::Worker

  def perform(authorization, order_id)
  	order = Order.find(order_id)
    payment = Payment.new
    
    payment.tap do |pay|
      pay.first_name = order.user.first_name
      pay.last_name = order.user.last_name
      pay.authorization_code = authorization
      pay.order_id = order_id
      pay.success = 'true'
      pay.save
    end
  end
end
