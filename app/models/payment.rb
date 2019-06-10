class Payment < ApplicationRecord
  include HasReference
  belongs_to :order, optional:true
  

  validates :first_name, presence: true
  validates :last_name, presence: true
  #validates :amount, presence: true

  enum status: {created: 0, succeeded: 1, pending: 2, failed: 3,
                refund_pending: 4, refunded: 5}

  

end
