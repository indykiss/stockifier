class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    redirect_to stocks_path 
  end

  def index 
    @current_user = User.find_by_id(session[:user_id])
  end 

  def create
    @user = User.create(params.require(:user).permit(:email,        
    :password))
    session[:user_id] = @user.id
    redirect_to '/'
    @user = User.new(user_params)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :uid)
    end
end
