class RestaurantsController < ApplicationController
  def index
    @line_item = current_order.line_items.new
    @restuarant_items = Restaurant.restaurant_items(params[:name])
  end

  def categories
    @restaurant_categories = Restaurant.restaurant_categories(params[:name])
  end
end
