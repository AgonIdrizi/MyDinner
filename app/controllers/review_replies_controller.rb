class ReviewRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  def create
  	@review_reply = current_user.review_replies.build(review_reply_params.except(:item_id))
  	if @review_reply.save
  	  flash[:success] = "Reply added succesfully"
  	  redirect_to @item and return
  	else
  	  flash.now[:danger] = "There was an error ading your reply, please try again"
  	  redirect_to items_path(id: @item.id) 
  	end
  end

  private
    def review_reply_params
      params.require(:review_replies).permit(:review_id, :title, :description)
    end

    def set_item
      @item = Item.find_by(id: params[:review_replies][:item_id])
    end
end
