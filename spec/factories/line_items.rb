FactoryBot.define do
  factory :line_items do
  	association :order
  	association :item
  	quantity {1}
  	unit_price {item.price}
  	total_price
  end
end