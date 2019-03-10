require 'rails_helper'

RSpec.feature "User can browse items", type: :feature do
  before do
  	create_items
    create_categories
    create_item_category_relationship
  end
  scenario "we should see list of all items" do
  	visit root_path

  	expect(page).to have_content(@item5.name)
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