class Restaurant < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders
  has_many :restaurants_categories
  has_many :categories, through: :restaurants_categories
  has_many :restaurants_items
  has_many :items, through: :restaurants_items
  validates :name, :location, :city, :state, presence: true
  

  def self.restaurant_categories(name_param)
    self.find_by_name(name_param.split(' ').join('-')).categories
  end

  def self.restaurant_items(name_param)
    self.find_by_name(name_param.split(' ').join('-')).items
  end
end
