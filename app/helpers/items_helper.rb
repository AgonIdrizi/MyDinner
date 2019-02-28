module ItemsHelper

  def search_by_category(params)
  	return false if params[:category].nil? 
    if Item.item_category_types.values.include?(params[:category].to_i)
      find_category_from_params(params[:category])
    else
      return false
    end
  end

  def find_category_from_params(category)
  	case category 
      when '0'
        @items = Item.category_starters
      when '1'
        @items = Item.category_seafood
      when '2'
       @items =  Item.category_salads
      when '3'
       @items = Item.category_local_food
      when '4'
       @items = Item.category_fast_food
      when '5'
       @items = Item.category_beverages
      when '6'
       @items = Item.category_deserts
  	end
  end
end
