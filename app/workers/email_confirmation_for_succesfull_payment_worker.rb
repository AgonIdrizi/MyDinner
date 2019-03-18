class EmailConfirmationForSuccesfullPaymentWorker
  include Sidekiq::Worker

  def perform(order_id)
    OrderPaymentSuccessfullMailer.order_payment_successfull(order_id).deliver_now
  end
end