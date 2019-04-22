class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :review_replies
  validate :review_can_be_editet_after_15_of_creation , on: :update
  validates :user_id, presence: true, uniqueness: {scope: :item_id}
  
  def review_can_be_editet_after_15_of_creation
  	if self.created_at + 15.minutes > Time.now
  	  errors.add(:base, 'Review cant be edited, 15 min after creation')
  	end
  end
end
