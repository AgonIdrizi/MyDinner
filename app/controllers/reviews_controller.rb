class ReviewsController < ApplicationController
  before_action :set_item

  def create
  	@review = current_user.reviews.build(reviews_params)
  	debugger
  	if @review.save
  	  redirect_to @item, notice: 'Review was succesfully added' and return
  	else
  	  redirect_to @item, notice: 'Ups something went wrong, review was not added' and return
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
