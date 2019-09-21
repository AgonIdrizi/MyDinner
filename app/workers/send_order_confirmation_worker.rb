class SendOrderConfirmationWorker
  include Sidekiq::Worker

  def perform(order_id, user)
    OrderConfirmationMailer.order_confirmation(order_id, user).deliver_now
  end
end
