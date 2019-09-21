class EmailConfirmationForSuccesfullPaymentWorker
  include Sidekiq::Worker

  def perform(order_id, user)
    OrderPaymentSuccessfullMailer.order_payment_successfull(order_id, user).deliver_now
  end
end