class ReviewReply < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates_presence_of :description
end
