require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'Item create' do
    it "should be valid" do
      @restaurant = FactoryBot.create(:restaurant)
      expect(@restaurant).to  be_instance_of(Restaurant)
    end

    it "should not be valid with empty name" do
      @restaurant = FactoryBot.build(:restaurant, name: '')
      @restaurant.save
      expect(@restaurant.errors.full_messages).to include("Name can't be blank")
    end

    it "should not be valid with empty location" do
      @restaurant = FactoryBot.build(:restaurant, location: '')
      @restaurant.save
      expect(@restaurant.errors.full_messages).to include("Location can't be blank")
    end

    it "should not be valid with empty city" do
      @restaurant = FactoryBot.build(:restaurant, city: '')
      @restaurant.save
      expect(@restaurant.errors.full_messages).to include("City can't be blank")
    end

    it "should not be valid with empty state" do
      @restaurant = FactoryBot.build(:restaurant, state: '')
      @restaurant.save
      expect(@restaurant.errors.full_messages).to include("State can't be blank")
    end

  end
end
