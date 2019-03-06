class PaymentsController < ApplicationController
  before_action :authenticate_user!
  #before_action :ensure_order_isnt_empty, only: :new
  def new
    @payment = Payment.new
    order = Order.find_by(id: session[:order_id_for_payment])
   
  end

  def create
    order = Order.find_by(id: session[:order_id_for_payment])
    amount = 1000
    @charge = ChargeCreditCard.new(order.total, params[:token])
    @payment = order.build_payment
    debugger
    if @charge.processed

      #save payment object with params returned from @charge.transaction
      #UpdatePaymentObjectAfterChargeWorker.perform(@payment, @charge.transaction)
      #
        session[:order_id_for_payment]=nil
        #sent email_confirmation_for_succesfull_payment
        UpdateOrderStatusAfterChargeWorker.perform_async(order.id)
        
        flash[:success] =  "Successfully charged $#{sprintf("%.2f", amount)} to the credit card #{@payment.last4}"
        redirect_to order and return
    end
    render 'new'
    
   
  end

  private

  def ensure_order_isnt_empty
    if session[:order_id_for_payment].present?
      redirect_to root_path, notice: 'Your cart is empty, please add items to your cart'
    end
  end

  def charge_params
    params.permit(:first_name, :last_name, :token )
  end
end
