class OrderConfirmationMailer < ApplicationMailer
  
  def order_confirmation(order_id, email)
	order = Order.find(order_id)
  	@name = order.user_id.nil? ? email : User.find(order.user_id).first_name
  	subject = "Order ##{order.id} was succesfully placed"
  	mail(to: email, subject: subject)
  end
end
