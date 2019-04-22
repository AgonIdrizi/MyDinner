class Recommendation
  

  #find three popular other items customers have ordered with this item
  def self.find_three_other_items(item_lookup_id, current_user_id)
    counter_hash = LineItem.joins(:order).where("user_id != #{current_user_id}").group('line_items.item_id').count
    ids = counter_hash.sort_by {|k,v| v}.reverse.to_h.reject {|k,v| k == item_lookup_id}.first(3).to_h.keys
    Item.where('id IN (?)',ids)
  end

  
end