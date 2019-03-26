class ReviewsController < ApplicationController
  before_action :set_item

  def create
  	@review = current_user.reviews.build(reviews_params)
  	if @review.save
  	  redirect_to @item, notice: 'Review was succesfully added' and return
  	else
  	  redirect_to @item, notice: 'something went wrong or you cant add more than 1 review' and return
  	end
  end

private

  def reviews_params
  	params.require(:review).permit(:title, :body, :item_id, :star_rating)
  end
  
  def set_item
  	@item = Item.find_by(id: params[:item_id])
  end

end
