require 'rails_helper'
RSpec.feature "User can add last-order items, in the cart", type: :feature do
  
  
  before do
    create_items
    create_categories
    create_item_category_relationship
    @user = FactoryBot.create(:user)
  	login_as(@user, scope: :user)
    create_last_order_with_line_items
  end

  specify 'add last order items in cart' do
  	visit root_path
  	
  	add_last_order_items_to_cart

    expect(page).to have_content(@item1.name)

    save_and_open_page
  end


 
  def create_last_order_with_line_items
    last_order = FactoryBot.create(:order, user_id: @user.id)
    last_order.line_items.create(item_id: @item1.id, quantity: 1)
    last_order.line_items.create(item_id: @item2.id, quantity: 2)
    last_order.update_attributes(order_status_type: Order::order_status_types["paid"], status: 'paid')
    last_order.save
  end

  def add_last_order_items_to_cart
    find(:css ,"input[id='last-order']").click
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