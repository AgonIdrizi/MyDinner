FactoryBot.define do
  factory :order do
	order_status_type {Order::order_status_types["ordered"]}
	status {"ordered"}
    trait :with_line_items do	
      after(:create) {|order| create_list(:line_items,5,order: order)}
    end
  end
end