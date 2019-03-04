require 'rails_helper'

RSpec.feature "User can't be charged with invalid card data", type: :feature do
  before do
  	create_items
  	user = FactoryBot.create(:user)
  	login_as(user, scope: :user)
  end
  scenario '' do
  	visit root_path

  	add_items_to_cart

  	visit cart_path

  	click_button 'Checkout'

  	fill_checkout_form_with_valid_info

  	click_on 'Place Order'

  	expect(page).to have_content('Order was succesfully placed')

  	fill_in 'First name', with: 'Agon'
  	fill_in 'Last name', with: 'Idrizi'
  	fill_in 'Credit card number', with: '2341324323'
  	page.select '7', from: 'Expiration month'
  	page.select '2020', from: 'Expiration year' 
  	fill_in 'Card security code', with:1222
  	click_on 'Charge Credit Card'

  	expect(page).to have_content('The credit card information you provided is not valid. Please double check the information you provided and then try again.')
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
    @item1 = FactoryBot.create(:item, :with_category_starters)
    @item2 = FactoryBot.create(:item, :with_category_seafood)
    @item3 = FactoryBot.create(:item, :with_category_salads)
    @item4 = FactoryBot.create(:item, :with_category_local_food)
    @item5 = FactoryBot.create(:item, :with_category_beverages)
    @item6 = FactoryBot.create(:item, :with_category_deserts)
  end
end