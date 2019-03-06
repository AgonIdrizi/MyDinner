class UpdateOrderStatusAfterChargeWorker
  include Sidekiq::Worker

  def perform(order_id)
    order = Order.find(order_id)
    order.update_attributes(status: 'paid')
  end
end
