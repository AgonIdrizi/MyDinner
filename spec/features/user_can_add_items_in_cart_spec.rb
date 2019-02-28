require 'rails_helper'

RSpec.feature "User can add items in cart", type: :feature do
  before do
  	create_items
  end
  	
  scenario "we can add items in cart" do
  	visit root_path
    
  	add_items_to_cart

  	visit cart_path

  	expect(page).to have_content('2 Items in Cart')
    
  end

  scenario "we can update items in cart" do
  	visit root_path
    
  	add_items_to_cart

  	visit cart_path

  	update_quantity_of_item

  	expect(page).to have_content('2 Items in Cart')
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