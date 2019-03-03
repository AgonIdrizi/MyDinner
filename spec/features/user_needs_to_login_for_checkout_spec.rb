require 'rails_helper'

RSpec.feature "User needs to login before checkout", type: :feature do
  
describe "" do
  before do
    create_items
  end

  
    
  scenario "not loged in user tries to checkout" do
    visit root_path
    
    add_items_to_cart

    visit cart_path

    expect(page).to have_content('2 Items in Cart')
    
    click_button 'Checkout'


    expect(page).to have_content('You need to sign in or sign up before continuing.')

    click_for_sign_up
    
    fill_sign_up_form

    expect(url).to eq(new_checkout_path)
  end

  def click_for_sign_up
    find('a[href$="/users/sign_up"]').click
  end

  def fill_sign_up_form
    fill_in 'Name',                  with: 'James'
    fill_in 'Email',                 with: 'james@testrspec.com'
    fill_in 'Password',              with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
  end

  def url
    URI.parse(current_url).path
  end

  def update_quantity_of_item
    within find("form", match: :first) do
      fill_in "line_item[quantity]", with: "7"
      find_button('Update Quantity').click
    end
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

  def create_items
    @item1 = FactoryBot.create(:item, :with_category_starters)
    @item2 = FactoryBot.create(:item, :with_category_seafood)
    @item3 = FactoryBot.create(:item, :with_category_salads)
    @item4 = FactoryBot.create(:item, :with_category_local_food)
    @item5 = FactoryBot.create(:item, :with_category_beverages)
    @item6 = FactoryBot.create(:item, :with_category_deserts)
  end
end
end