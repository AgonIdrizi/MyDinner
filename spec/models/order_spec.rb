require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Order create' do
  	
  	it 'should be valid' do
  	  @order = FactoryBot.create(:order)
  	  expect(@order).to be_instance_of(Order)
  	end

  	it 'should not be valid' do
  	  @order = FactoryBot.build(:order, status: '')
  	  @order.save
  	  expect(@order.errors.full_messages).to include("Status can't be blank")
  	end
  end
  describe 'Order creation with line items' do
  	before do
  	  @order = FactoryBot.create(:order)
  	  @item = FactoryBot.create(:item)
  	end
  	it "should have line items" do
  	expect {
  	 @order.line_items.create( item_id: @item.id, quantity: 1)
  	}.to change(@order.line_items, :count).by(1)
  	end
  end
end
