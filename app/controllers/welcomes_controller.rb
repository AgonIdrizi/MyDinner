class WelcomesController < ApplicationController
  
  def welcome
  	@line_item = current_order.line_items.new
  	@items = Item.all.where(active: true)
  end
end
