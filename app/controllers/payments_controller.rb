class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
    order = Order.find_by(id: session[:order_id_for_payment])
    @amount = order.total
  end

  def create
    order = Order.find_by(id: session[:order_id_for_payment])
    amount = order.total
    @payment = Payment.new(charge_params)
    
    if @payment.save
      if @payment.process
        session[:order_id_for_payment]=nil
        #sent email_confirmation_for_succesfull_payment
        order.update_attributes(status: 'paid')
        flash[:success] =  "Successfully charged $#{sprintf("%.2f", amount)} to the credit card #{@payment.last4}"
        redirect_to order and return
      end
    end
    render 'new'
    
   
  end

  private
  def charge_params
    params.require(:payment).permit(:first_name, :last_name,:amount, :credit_card_number, :expiration_month, :expiration_year, :card_security_code,:order_id )
    
  end
end
