require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Item create' do
  	
  	it 'should be valid' do
  		@item = FactoryBot.create(:item)
  	  expect(@item).to be_instance_of(Item)
  	end

  	it 'should not be valid with empty name' do
  	  @other_item = FactoryBot.build(:item, name: '')
  	  @other_item.save
  	  expect(@other_item.errors.full_messages).to include("Name can't be blank")
  	end
    it 'should not be valid with empty description' do
      @other_item = FactoryBot.build(:item, description: '')
      @other_item.save
      expect(@other_item.errors.full_messages).to include("Description can't be blank")
    end

    it 'should not be valid with wrong image format' do
      @item = FactoryBot.build(:item, :with_wrong_image_format)
      @item.save
      expect(@item.errors.full_messages).to include("Image The image wrong format")
    end

  end

  describe 'Item update' do
    it 'should not be valid with wrong sales percentage data' do
      @item = FactoryBot.build(:item, sales: {price: 120.0, percentage: 4.3, status:true})
      @item.save
      expect(@item.errors.full_messages).to include("Sales Percentage must be integer")
    end

    it 'should not be valid with wrong sales price data' do
      @item = FactoryBot.build(:item, sales: {price: 120, percentage: 4, status:true})
      @item.save
      expect(@item.errors.full_messages).to include("Sales Price must be float")
    end

     it 'should not be valid with wrong sales status data' do
      @item = FactoryBot.build(:item, sales: {price: 120.0, percentage: 4, status:'fake'})
      @item.save
      expect(@item.errors.full_messages).to include("Sales Status must be boolean")
    end
  end
end
