class Order < ApplicationRecord
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :order_status
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
  	order_items.collect {|oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

private
  def set_order_status
  	self.order_status_id = 1
  end

  def update_subtotal
  	#update subtotal field, by assigning to it the subtotal method
  	self[:subtotal] = subtotal
  end
end
