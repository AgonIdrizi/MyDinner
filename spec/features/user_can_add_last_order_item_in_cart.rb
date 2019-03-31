require 'rails_helper'
RSpec.feature "User can add last-order items, in the cart", type: :feature do
  
  
  before do
    create_items
    create_categories
    create_item_category_relationship
    user = FactoryBot.create(:user)
  	login_as(user, scope: :user)
  end

  specify 'add last order items in cart' do
  	visit root_path
  	
  	add_items_to_cart

  	visit cart_path

  	click_button 'Checkout'

  	fill_checkout_form_with_valid_info

  	click_on 'Place Order'

  	expect(page).to have_content('Order was succesfully placed')

  	fill_payment_form
  	
  	click_on 'Charge Credit Card'

  	expect(page).to have_content('Successfully charged')
  	save_and_open_page
  	#find(:css ,"input[id='last-order']").click
  end


 
  def fill_payment_form
  	fill_in 'First name', with: 'Agon'
  	fill_in 'Last name', with: 'Idrizi'
  	fill_in 'Card Number', with: '4012000100000007'
  	fill_in 'CVC', with: '123'
  	find(:css ,'input[data-securionpay="expMonth"]').set('06')
  	find(:css ,'input[data-securionpay="expYear"]').set('2020')
  end

  def add_items_to_cart
    within ".item-#{@item1.id}" do
      find_button('Add to Cart').click
    end

    within ".item-#{@item2.id}" do
      fill_in "line_item[quantity]", with: "3"
      find_button('Add to Cart').click
    end
  end

  def fill_checkout_form_with_valid_info
  	fill_in 'Line1', with: 'Gostivarska 26'
  	fill_in 'State', with: 'MK'
  	fill_in 'City', with: 'Tetovo'
  	fill_in 'Postal code', with: 12000
  end


  def create_items
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    @item3 = FactoryBot.create(:item)
    @item4 = FactoryBot.create(:item)
    @item5 = FactoryBot.create(:item)
    @item6 = FactoryBot.create(:item)
  end
  def create_categories
    @category1 = FactoryBot.create(:category)
    @category2 = FactoryBot.create(:category)
    @category3 = FactoryBot.create(:category)
    @category4 = FactoryBot.create(:category)
    @category5 = FactoryBot.create(:category)
  end

  def create_item_category_relationship
    @item1.items_categories.create(category_id: @category1.id)
    @item2.items_categories.create(category_id: @category2.id)
    @item3.items_categories.create(category_id: @category3.id)
    @item4.items_categories.create(category_id: @category4.id)
  end
end