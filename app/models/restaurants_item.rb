class RestaurantsItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :item

  validates_uniqueness_of :item_id, scope: :restaurant_id
end
