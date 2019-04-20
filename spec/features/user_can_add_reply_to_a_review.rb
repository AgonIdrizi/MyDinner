require 'rails_helper'
RSpec.feature "User can add reply to a review", type: :feature do
  
  before do
    create_items
    create_categories
    create_item_category_relationship
    user = FactoryBot.create(:user)
  	login_as(user, scope: :user)
  end

  scenario 'user can add reply to a review', js:true do
    visit item_path(@item1)

    fill_review_form_with_star_selection
      
    expect(page).to have_content('Just a test body')
    
    select_first_review(click_reply)

    fill_in_a_reply_form

    select_first_review(click_show_replies)
    
    expect(page.body).to have_content('My first reply')
  end

  def click_reply
  	find('.reply').click
  end

  def click_show_replies
  	find('.show-replies')
  end

  def select_first_review(matcher)
  	within ('.reviews') do
      within('.review-section') do
      	within('.comment',match: :first) do
      	  matcher
      	end
      end
    end
  end

  def fill_in_a_reply_form
  	within(:css, "form#reply-review-form") do
      fill_in "review_replies_title", with: 'My first reply'
      fill_in "review_replies_description", with: 'This is just a reply description'
      click_button 'Add reply'
    end
  end

  def fill_review_form_with_star_selection
    within(:css, "form#review-form") do
  	  within('.form-group') do
  	  	within find('.radio-inline',match: :first) do
  	  	  find(:css,'i.fa' ).click
  	  	end
  	  end
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