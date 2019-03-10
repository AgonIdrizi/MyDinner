class ItemsCategory < ApplicationRecord
  belongs_to :item
  belongs_to :category

  validates :item_id, uniqueness: {scope: :category_id}
end