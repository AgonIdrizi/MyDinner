require 'rails_helper'

RSpec.feature "User can't add retired items in cart", type: :feature do
  before do	
  	@not_active_item = FactoryBot.create(:item, active: false)
  	@active_item = FactoryBot.create(:item, active: false)
  end

  scenario 'Add to Cart button is not shown for retired products' do
  	visit item_path(@not_active_item.id)

  	expect(page).to_not have_content('Add to Cart')
  end
end