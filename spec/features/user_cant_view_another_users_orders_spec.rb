require 'rails_helper'

RSpec.feature "User can't view another users orders", type: :feature do
  before do	
  	user = FactoryBot.create(:user)
  	other_user = FactoryBot.create(:user)
  	@order = FactoryBot.create(:order, user_id: other_user.id)
  	login_as(user, scope: :user)
  end
  scenario 'user tries to visit orders created by others' do
  	visit root_path

  	visit order_path(@order.id)

  	expect(page).to have_content('Unauthorized')
  	expect(url).to eq(root_path)
  end

  def url
    URI.parse(current_url).path
  end
end