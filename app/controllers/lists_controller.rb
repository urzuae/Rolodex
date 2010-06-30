class ListsController < ApplicationController
  def create_list
    @list = current_user.list.build(params[:current_user_id])
    if @list.save
      redirect_to groups_path
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
