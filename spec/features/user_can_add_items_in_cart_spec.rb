require 'rails_helper'

RSpec.feature "User can add items in cart", type: :feature do
  
  describe "" do
    before do
      create_items
      create_categories
      create_item_category_relationship
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
  	within ".shopping-cart" do
       within find("form", match: :first) do
  	    fill_in "line_item[quantity]", with: "7"
  	    find_button('Update Quantity').click
      end
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
end