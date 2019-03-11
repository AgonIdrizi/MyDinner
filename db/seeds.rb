# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Categories
Category.delete_all
c1 = Category.create(name:'starters')
c2 = Category.create(name:'seafood')
c3 = Category.create(name:'salads')
c4 = Category.create(name:'local food')
c5 = Category.create(name:'fast food')
c6 = Category.create(name:'beverages')
c7 = Category.create(name:'deserts')

#Items

Item.delete_all

20.times do
  Item.create(name: Faker::Food.dish, description: Faker::Food.description, price_cents: 17000, active: true)
end

Item.find(1).items_categories.create(category_id: c1)
 Item.find(1).items_categories.create(category_id: c2)
Item.find(2).items_categories.create(category_id: c1)
 Item.find(2).items_categories.create(category_id: c3)
Item.find(3).items_categories.create(category_id: c4)
 Item.find(3).items_categories.create(category_id: c3)
Item.find(4).items_categories.create(category_id: c1)
 Item.find(4).items_categories.create(category_id: c5)
Item.find(5).items_categories.create(category_id: c5)
 Item.find(5).items_categories.create(category_id: c4)
Item.find(6).items_categories.create(category_id: c3)
 Item.find(6).items_categories.create(category_id: c4)
Item.find(7).items_categories.create(category_id: c2)
 Item.find(7).items_categories.create(category_id: c4)
Item.find(8).items_categories.create(category_id: c5)
 Item.find(8).items_categories.create(category_id: c6)
Item.find(9).items_categories.create(category_id: c2)
 Item.find(9).items_categories.create(category_id: c7)
Item.find(10).items_categories.create(category_id: c2)
 Item.find(10).items_categories.create(category_id: c3)
Item.find(11).items_categories.create(category_id: c1)
 Item.find(11).items_categories.create(category_id: c3)
Item.find(12).items_categories.create(category_id: c3)
Item.find(13).items_categories.create(category_id: c5)
Item.find(14).items_categories.create(category_id: c7)
Item.find(15).items_categories.create(category_id: c4)

#Orders

  #Order.create(subtotal: nil, tax: nil, total: nil, status: Order::order_status_types.keys[0] , order_status_type: 0, user_id: nil, order_submitted_at: nil, order_completed_at: nil, order_cancelled_at: nil)
  #Order.create(subtotal: nil, tax: nil, total: nil, status: Order::order_status_types.keys[0] , order_status_type: 0, user_id: nil, order_submitted_at: nil, order_completed_at: nil, order_cancelled_at: nil)




#Users

User.delete_all

User.create(first_name: 'Rachel',last_name: 'Warbelow', display_name: '', email: 'demorachel@mydinner.com', password: 'password', password_confirmation: 'password')
User.create(first_name: 'Jeff',last_name: 'Casimir', display_name: 'j3', email: 'demojeff@mydinner.com', password: 'password', password_confirmation: 'password')
User.create(first_name: 'Jorge',last_name: 'Tellez', display_name: 'novohispano', email: 'demojorge@mydinner.com', password: 'password', password_confirmation: 'password')
User.create(first_name: 'Josh',last_name: 'Cheek', display_name: 'josh', email: 'demojosh@mydinner.com', password: 'password', password_confirmation: 'password')