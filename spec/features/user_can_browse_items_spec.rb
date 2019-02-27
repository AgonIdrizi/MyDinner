require 'rails_helper'

RSpec.feature "User can browse items", type: :feature do
  before do
  	create_items
  end
  scenario "we should see list of all items" do
  	visit root_path

  	expect(page).to have_content(@item6.name)
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