module SalesHelper
  
  def all_active_sales
  	items = []
  	Item.all.map do |it|
  	  items << it if it.sales[:status] == true
  	end
  	items
  end

  def set_item_on_sale(id,percentage)
  	i = Item.find_by(id: id)
  	i.sales[:percentage] = percentage
  	i.sales[:price] = i.sales[:percentage].to_f/100 * i.price
  	i.sales[:price] = i.price - i.sales[:price]
  	i.sales[:status] = true
  	i.save
  end
end
