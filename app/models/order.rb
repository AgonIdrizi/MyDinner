class Order < ApplicationRecord
  enum order_status_type: ['unsubmitted','ordered','paid','cancelled','completed']
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user, optional: true
  has_one :payment
  before_save :set_order_status, :if => :new_record?
  before_update :update_subtotal
  before_update :update_total

  #validates :order_status_type, presence: true, numericality: { greater_than_or_equal: 0, less_than: 10 }
  #validates :status, presence: true

  def subtotal
  	line_items.collect {|li| li.valid? ? (li.quantity * li.unit_price) : 0 }.sum
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
end
