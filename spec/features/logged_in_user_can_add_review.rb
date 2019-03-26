require 'rails_helper'
RSpec.feature "User can add review to items", type: :feature do
  
  
  before do
    create_items
    create_categories
    create_item_category_relationship
    user = FactoryBot.create(:user)
  	login_as(user, scope: :user)
  end

  scenario 'user can add review to items', js:true do
  	visit item_path(@item1)

  	fill_review_form_without_selecting_stars
  	
  	expect(page).to have_content('Just a test title')
  	
  end

  scenario 'user cant add more than one review' do
  end

  def fill_review_form_without_selecting_stars
  	within(:css, "form#review-form") do
  	  
  	  fill_in "review_title", with: 'Just a test title'
  	  fill_in "review_body", with: 'Just a test body'
  	  click_button 'Add review'
  	end
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