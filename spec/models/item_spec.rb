require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Item create' do
  	
  	it 'should be valid' do
  		@item = FactoryBot.create(:item)
  	  expect(@item).to be_instance_of(Item)
  	end

  	it 'should not be valid' do
  	  @other_item = FactoryBot.build(:item, name: '')
  	  @other_item.save
  	  expect(@other_item.errors.full_messages).to include("Name can't be blank")
  	end
  end
end
