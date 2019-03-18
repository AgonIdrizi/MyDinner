class OrderPaymentSuccessfullMailer < ApplicationMailer
  
  def order_payment_successfull(order_id)
  	@order = Order.find(order_id)
  	@user = User.find(@order.user_id)
  	@order_pickup_time = @order.pickup_time.strftime('%I:%M%p %m/%d/%Y')
  	subject = "Payment for order ##{@order.id} was succesfull "
  	mail(to: @user.email, subject: subject)
  end
end
