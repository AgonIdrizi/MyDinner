class Order < ApplicationRecord
  enum order_status_type: ['ordered','paid','cancelled','completed']
  has_many :line_items
  has_many :items, through: :line_items
  before_create :set_order_status
  before_save :update_subtotal

  validates :order_status_type, presence: true, numericality: { greater_than_or_equal: 0, less_than: 10 }
  validates :status, presence: true

  def subtotal
  	line_items.collect {|oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

private
  def set_order_status
  	self.order_status_type = 0
    self.
  end

  def update_subtotal
  	#update subtotal field, by assigning to it the subtotal method
  	self[:subtotal] = subtotal
  end
end
