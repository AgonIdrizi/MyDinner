class CheckoutForm
  include ActiveModel::Model
  attr_reader :email, :line1, :state, :city, :postal_code, :current_user
  validates :email, presence: true
  validates :line1, :state, :city, :postal_code, presence: true
  validates :postal_code, format: {with: /\d{5}/}

  def initialize(order={},params={}, current_user_id)
  	@order = order
  	@email = params[:email]
  	@line1 = params[:line1]
  	@state = params[:state]
  	@city = params[:city]
  	@postal_code = params[:postal_code]
    @user_id = current_user_id
  end

  def save
  	if valid?
  	  ActiveRecord::Base.transaction do
        @order.update_attributes(status: 'ordered', order_status_type:'ordered', user_id: @user_id)
      end
      true
  	else
  	  false
  	end
  end
end