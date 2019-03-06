class SendOrderConfirmationWorker
  include Sidekiq::Worker

  def perform(order_id)
    OrderConfirmationMailer.order_confirmation(order_id).deliver_now
  end
end
