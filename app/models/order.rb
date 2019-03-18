class Order < ApplicationRecord
  enum order_status_type: ['unsubmitted','ordered','paid','cancelled','completed']
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user, optional: true
  has_one :payment
  before_save :set_order_status, :if => :new_record?
  before_update :update_subtotal
  before_update :update_total
  before_update :update_order_submitted_at_timestamp
  before_update :update_order_cancelled_at_timestamp
  before_update :update_order_completed_at_timestamp

  #validates :order_status_type, presence: true, numericality: { greater_than_or_equal: 0, less_than: 10 }
  #validates :status, presence: true

  scope :paid_orders, -> {where(status: 'paid')}

  def subtotal
  	line_items.collect {|li| li.valid? ? (li.quantity * li.unit_price) : 0 }.sum
  end

  def pickup_time
    item_prep_time =  items.pluck(:preparation_time)

    #if order has more than six items, add 10 minutes for every additional six items
    (item_prep_time.size/6 != 0) ? (item_prep_time<< (item_prep_time.size/6-1)*10) : false
    #check for orders with status-paid in the system, add additional 4 min. for every order which is paid and not completed
    item_prep_time << (Order.paid_orders.size * 4)
    
    Time.now + item_prep_time.sum.minutes
  end

private
  def set_order_status
  	self.order_status_type = 0
    self.status = 'unsubmitted'
  end

  def update_subtotal
  	#update subtotal field, by assigning to it the subtotal method
  	self[:subtotal] = subtotal
  end

  

  def update_total
    self[:total] = subtotal
  end

  def update_order_submitted_at_timestamp
    if self.status == 'ordered'
      self[:order_submitted_at] = Time.now
    end
  end

  def update_order_cancelled_at_timestamp
    if self.status == 'cancelled'
      self[:order_cancelled_at] = Time.now
    end
  end

  def update_order_completed_at_timestamp
    if self.status == 'completed'
      self[:order_completed_at] = Time.now
    end
  end

end
