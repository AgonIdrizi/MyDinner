class PaymentsController < ApplicationController
  before_action :authenticate_user!
  #before_action :ensure_order_isnt_empty, only: :new
  def new
    @payment = Payment.new
    order = Order.find_by(id: session[:order_id_for_payment])
   
  end

  def create
    order = Order.find_by(id: session[:order_id_for_payment])
    amount = order.total.to_i
    #charge = ChargeCreditCard.new(1000, params[:token])
    
    if charge.processed
      #save payment object with params returned from charge.transaction
      #UpdatePaymentObjectAfterChargeWorker.perform_async(charge.transaction.authorization, order.id)
      #
      #session[:order_id_for_payment]=nil
      #sent email_confirmation_for_succesfull_payment
     # EmailConfirmationForSuccesfullPaymentWorker.perform_async(order.id)
      # update status of the order after sucessfull payment
      #UpdateOrderStatusAfterChargeWorker.perform_async(order.id)
        
      flash[:success] =  "Successfully charged $#{sprintf("%.2f", amount)} to the credit card #{charge.transaction.params["card"]["last4"]}"
      redirect_to order and return
    end
    flash.now[:danger] = "We couldn't charge your card, please check your card data"
    render 'new'
    
   
  end

  private

  def ensure_order_isnt_empty
    if session[:order_id_for_payment].nil?
      redirect_to root_path, notice: 'Your cart is empty, please add items to your cart'
    end
  end

  def create_workflow(payment_type)
    case payment_type
      when 'paypal' then paypal_workflow
    else
      securion_workflow
    end
  end

  def paypal_workflow
    PurchasesCartViaPaypal.new(
      user: current_user,
      purchase_amount_cents: 1000)
  end

  def securion_workflow
    PurchasesCartViaStripe.new(
      user:current_user,
      stripe_token: params[:token],
      purchase_amount_cents: 1000)
  end

  def charge_params
    params.permit(:first_name, :last_name, :token, :payment_type )
  end
end
