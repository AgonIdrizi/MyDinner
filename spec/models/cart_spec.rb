require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'Cart' do
  	before do
  	  @order = FactoryBot.create(:order)
  	  @item1 = FactoryBot.create(:item)
  	  @item2 = FactoryBot.create(:item)
  	end
  	it "clear_cart method should empty a cart" do 
  		@order.line_items.create( item_id: @item1.id, quantity: 1)
  		@order.line_items.create( item_id: @item2.id, quantity: 2)
  		Cart.clear_cart @order
  		expect(@order.line_items.count).to eq(0)
  	end

  end
end
