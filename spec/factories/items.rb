FactoryBot.define do
  factory :item do
  	name {"Spaghetti bolognese"}
  	description {"Finnest spaghetti in town, made with handmade sauce"}
  	price {10000}
  	currency { "$" }
  	image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'kittens.jpg'), 'image/jpg') }
  end
end