module ItemsHelper

  def search_by_category(params)
  	return false if params[:category].nil? 
    if Item.item_category_types.keys.include?(params[:category])
      find_category_from_params(params[:category])
    else
      return false
    end
  end

  def find_category_from_params(category)
  	case category 
      when 'starters'
        @items = Item.category_starters
      when 'seafood'
        @items = Item.category_seafood
      when 'salads'
       @items =  Item.category_salads
      when 'local_food'
       @items = Item.category_local_food
      when 'fast_food'
       @items = Item.category_fast_food
      when 'beverages'
       @items = Item.category_beverages
      when 'deserts'
       @items = Item.category_deserts
  	end
  end
end
