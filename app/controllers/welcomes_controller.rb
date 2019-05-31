class WelcomesController < ApplicationController
  
  def welcome
  	@items = Item.all.where(active: true)
  end
end
