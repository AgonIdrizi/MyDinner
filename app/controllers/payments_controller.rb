class PaymentsController < ApplicationController
  before_action :ensure_checkout

  before_action :set_order_or_redirect, only: [:create, :new]
  
  def new
    @payment = Payment.new
  end


  def create
    @amount = @order.total.to_i
    @user = get_current_user(session[:email], params[:first_name],params[:last_name])
    
    workflow = create_workflow(params[:payment_type])
    workflow.run
    if workflow.success
      session[:order_id] = nil
      session[:email] = nil
      session[:checkout] = false
      flash[:success] =  "Successfully charged"
      redirect_to workflow.redirect_on_success_url || @order and return
    else
      flash.now[:danger] = "We couldn't charge your card, please check your card data"
      render 'new'
    end
  end

  private

  def set_order_or_redirect
    @order = Order.find_by(id: session[:order_id])
    if @order.line_items.length == 0
      redirect_to root_path, notice: 'Your cart is empty, please add items to your cart' and return
    end
  end

  def ensure_checkout
    if !session[:checkout]
      redirect_to new_checkout_path, notice: 'You need to checkout first' and return
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
      user: @user,
      order: @order,
      purchase_amount_cents: @amount)
  end

  def securion_workflow
    PurchasesCartViaSecurion.new(
      user: @user,
      order: @order,
      securion_token: params[:token],
      purchase_amount_cents: @amount)
  end

  def charge_params
    params.permit(:first_name, :last_name, :token, :payment_type )
  end
end
