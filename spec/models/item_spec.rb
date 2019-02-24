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
end
