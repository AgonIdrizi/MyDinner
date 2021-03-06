class Order < ApplicationRecord
  enum order_status_type: ['unsubmitted','ordered','paid','cancelled','completed']
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user, optional: true
  belongs_to :restaurant
  has_one :payment
  before_save :set_order_status, :if => :new_record?
  before_update :update_subtotal, 
                :update_total, 
                :update_order_submitted_at_timestamp, 
                :update_order_cancelled_at_timestamp,
                :update_order_completed_at_timestamp
  validates :restaurant, presence: true
  #validates :order_status_type, presence: true, numericality: { greater_than_or_equal: 0, less_than: 10 }
  #validates :status, presence: true

  scope :paid_orders, -> {where(status: 'paid')}
  scope :created_before_3_hours, -> {where('created_at > ?',Time.now - 3.hours)}
  scope :not_completed, -> {where.not(order_completed_at: nil)}
  def subtotal
  	line_items.collect {|li| li.valid? ? (li.quantity * li.unit_price) : 0 }.sum
  end

  def pickup_time
    item_prep_time =  items.pluck(:preparation_time)

    #if order has more than six items, add 10 minutes for every additional six items
    (item_prep_time.size/6 != 0) ? (item_prep_time<< (item_prep_time.size/6-1)*10) : false
    #check for todays orders with status-paid in the system, add additional 4 min. for every order which is paid and not completed
    item_prep_time << (Order.created_before_3_hours.paid_orders.not_completed.size * 4)
    
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
