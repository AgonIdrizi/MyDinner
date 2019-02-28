class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  validates :email, presence: true, format: {with: /\A[^@\s]+@([^@.\s]+\.)*[^@.\s]+\z/}
  validates :name, presence: true
end
