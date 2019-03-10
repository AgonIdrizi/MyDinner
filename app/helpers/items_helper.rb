module ItemsHelper

  def search_by_category(params)
    #debugger
  	return false if params[:category].nil?
    if Category.all.pluck(:id).include?(params[:category].to_i)
      find_category_from_params(params[:category].to_i)
    else
      return false
    end
  end

  def find_category_from_params(category)
  	@items = Item.search_items_by_category(category)
  end
end
