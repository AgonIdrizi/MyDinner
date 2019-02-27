FactoryBot.define do
  factory :item do
  	sequence(:name) {|n|"Our menu #{n}"}
  	description {"Finnest spaghetti in town, made with handmade sauce"}
  	price {100}
  	currency { "$" }
  	image { fixture_file_upload(Rails.root.join('public', 'test', 'kittens.jpg'), 'image/jpg') }
  	category {'starters'}
  	item_category_type {0}


  	trait :with_wrong_image_format do
  	  image { fixture_file_upload(Rails.root.join('app', 'assets', 'test.pdf'), 'application/pdf') }
  	end
  	
  	trait :with_category_starters do
  	  category {'starters'}
  	  item_category_type {0}
  	end

  	trait :with_category_seafood do
  	  category {'seafood'}
  	  item_category_type {1}
  	end

  	trait :with_category_salads do
  	  category {'salads'}
  	  item_category_type {2}
  	end

  	trait :with_category_local_food do
  	  category {'local_food'}
  	  item_category_type {3}
  	end

  	trait :with_category_beverages do
  	  category {'beverages'}
  	  item_category_type {4}
  	end

  	trait :with_category_deserts do
  	  category {'deserts'}
  	  item_category_type {5}
  	end
  	
  end
end