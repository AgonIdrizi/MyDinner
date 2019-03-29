require 'rails_helper'

RSpec.describe Review, type: :model do
  
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  describe 'Review creation'do
    it 'creates a review' do
      @review = FactoryBot.build(:review, user_id: @user.id, item_id: @item.id)
      @review.save
      expect(@review.persisted?).to eq(true)
    end
  end

  describe 'Review update' do
  	it 'cant update review,within 15minutes after it was created' do
  	  @review = FactoryBot.build(:review, user_id: @user.id, item_id: @item.id)
      @review.save

      @review.update_attributes(star_rating: 5)
      expect(@review.errors.full_messages).to include('Review cant be edited, 15 min after creation')
  	end
  end
end
