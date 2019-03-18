FactoryBot.define do
  factory :item do
  	sequence(:name) {|n|"Our menu #{n}"}
  	description {"Finnest spaghetti in town, made with handmade sauce"}
  	price {100}
  	currency { "$" }
    active {true}
  	image { fixture_file_upload(Rails.root.join('public', 'test', 'kittens.jpg'), 'image/jpg') }
  	sales {{price: 123.0, percentage: 3, status:true}}


  	trait :with_wrong_image_format do
  	  image { fixture_file_upload(Rails.root.join('public', 'test', 'test.pdf'), 'application/pdf') }
  	end
  	
  	
  end
end