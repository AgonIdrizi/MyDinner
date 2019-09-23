module Constraint
class RestaurantConstraint
  def self.matches?(request)
    Restaurant.all.pluck(:name).include?(request.params[:name])
  end
end
end