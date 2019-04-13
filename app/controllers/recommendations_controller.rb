class RecommendationsController < ApplicationController
  def index
  	recomendation = Recommendation.find_three_other_items(params[:item_id].to_i, current_user_id_or_default)
  	respond_to do |format|
  	  format.json { render json: recomendation}
    end
  end

  private
   def current_user_id_or_default
   	 user = current_user || User.first
   	 user.id
   end
end
