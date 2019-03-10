require 'rails_helper'

RSpec.feature "User can checkout succesfully", type: :feature do
  before do
  	create_items
    create_categories
    create_item_category_relationship
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