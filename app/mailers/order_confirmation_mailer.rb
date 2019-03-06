class OrderConfirmationMailer < ApplicationMailer
  
  def order_confirmation(order_id)
  	@order = Order.find(order_id)
  	@user = User.find(@order.user_id)
  	subject = "Order ##{@order.id} was succesfully placed"
  	mail(to: @user.email, subject: subject)
  end
end
