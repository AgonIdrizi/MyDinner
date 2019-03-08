require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create user' do
  	before do
  	  @user = FactoryBot.create(:user)
  	end
    it "can create a user" do
  	  expect(@user).to be_truthy
    end

    it "doesn't allow user with empty name" do
    	@user.first_name = ""
    	@user.save
    	expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "doesn't allow user with wrong email format" do
    	@user = FactoryBot.build(:user, email: 'agon#agon.com')
    	@user.save
    	expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'doesnt allow duplicate emails' do
  	  other_user  = FactoryBot.build(:user, email: @user.email)
  	  other_user.valid?
  	  expect(other_user.errors[:email]).to include("has already been taken")
    end
  end
end
