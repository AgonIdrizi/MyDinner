FactoryBot.define do
  factory :item do
  	sequence(:name) {|n|"Our menu #{n}"}
  	description {"Finnest spaghetti in town, made with handmade sauce"}
  	price {100}
  	currency { "$" }
    active {true}
  	image { fixture_file_upload(Rails.root.join('public', 'test', 'kittens.jpg'), 'image/jpg') }
  	sales {{price: Money.new(0), percentage: 0, status: false}}


  	trait :with_wrong_image_format do
  	  image { fixture_file_upload(Rails.root.join('public', 'test', 'test.pdf'), 'application/pdf') }
  	end
  	
    trait :with_sales do
      sales {{price: Money.new(123), percentage: 3, status:true}}
      
    end
  	
  end
end