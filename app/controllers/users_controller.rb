class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :authorize_user
  def show
  	@user = User.find_by(id: params[:id])
    @orders = @user.orders
  end

private
  def authorize_user
  	if current_user.id == params[:id].to_i
  	  return true
  	else
  	  flash[:notice] = "You don't have persmision"
  	  redirect_to root_path
  	end
  end
end
