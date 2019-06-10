class Payment < ApplicationRecord
  include HasReference
  belongs_to :order, optional:true
  

  validates :first_name, presence: true
  validates :last_name, presence: true
  #validates :amount, presence: true

  

  

end
