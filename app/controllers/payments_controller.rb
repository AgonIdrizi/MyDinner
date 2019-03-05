class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
    order = Order.find_by(id: session[:order_id_for_payment])
   
  end

  def create
    order = Order.find_by(id: session[:order_id_for_payment])
    amount = 1000
    @charge = ChargeCreditCard.new(amount, charge_params)
    @payment = order.build_payment
    
    if @charge.processed
      #save payment object with params returned from @charge.transaction
      #
        session[:order_id_for_payment]=nil
        #sent email_confirmation_for_succesfull_payment
        order.update_attributes(status: 'paid')
        flash[:success] =  "Successfully charged $#{sprintf("%.2f", amount)} to the credit card #{@payment.last4}"
        redirect_to order and return
    end
    render 'new'
    
   
  end

  private
  def charge_params
    params.permit(:first_name, :last_name, :token )
    
  end
end
