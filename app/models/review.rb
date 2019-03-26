class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user_id, presence: true, uniqueness: {scope: :item_id}
  
end
