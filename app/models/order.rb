class Order < ApplicationRecord
  enum order_status_type: ['unsubmitted','ordered','paid','cancelled','completed']
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user, optional: true
  before_save :set_order_status, :if => :new_record?
  before_save :update_subtotal

  #validates :order_status_type, presence: true, numericality: { greater_than_or_equal: 0, less_than: 10 }
  #validates :status, presence: true

  def subtotal
  	line_items.collect {|oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
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
end
