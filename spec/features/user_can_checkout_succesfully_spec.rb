require 'rails_helper'

RSpec.feature "User can checkout succesfully", type: :feature do
  before do
  	create_items
  	user = FactoryBot.create(:user)
  	login_as(user, scope: :user)
  end
  
  scenario 'fill checkout form with invalid information' do
  	visit root_path

  	add_items_to_cart

  	visit cart_path

  	click_button 'Checkout'

  	fill_checkout_form_with_invalid_info

  	click_on 'Place Order'

  	expect(page).to have_content("City can't be blank")
  	expect(page).to have_content("Postal code is invalid")
  end
  scenario 'fill checkout form with valid information' do
  	visit root_path

  	add_items_to_cart

  	visit cart_path

  	click_button 'Checkout'

  	fill_checkout_form_with_valid_info

  	click_on 'Place Order'

  	expect(page).to have_content('Order was succesfully placed')
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

  def fill_checkout_form_with_invalid_info
  	fill_in 'Line1', with: 'Gostivarska 26'
  	fill_in 'State', with: 'MK'
  	fill_in 'City', with: ''
  	fill_in 'Postal code', with: 1200
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