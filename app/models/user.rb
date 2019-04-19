class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :reviews
  has_many :review_replies
  validates :email, presence: true, format: {with: /\A[^@\s]+@([^@.\s]+\.)*[^@.\s]+\z/}
  validates :first_name, presence: true
  validates :last_name, presence: true
end
