class ListsController < ApplicationController
  def create_list
    @user = User.find(params[:id])
    @list = List.new(:user_id => @user.id)
    if @list.save
      redirect_to login_path
    else
      redirec_to new_user_path
    end
  end
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_path
  end
end
