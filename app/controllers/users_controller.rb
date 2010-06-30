class UsersController < ApplicationController
  
  def show
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      #SingupMailer.deliver_singup_notification(@user)
      flash[:notice] = 'Thanks for registering'
      session[:user_id] = @user.id
      #redirect_to :controller => "lists", :action => :create_lst
      redirect_to groups_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end
  def edit
  end
  def update
  end
  def destroy
  end
end
