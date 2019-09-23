class Restaurant < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders
  has_many :restaurants_categories
  has_many :categories, through: :restaurants_categories
  has_many :items, through: :categories
  validates :name, :location, :city, :state, presence: true
end
