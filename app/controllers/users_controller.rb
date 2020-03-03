class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]


  def new
    @user = User.new
  end

  def show
    redirect_to stocks_path 
  end

  def index 
    current_user = User.find_by_id(session[:user_id])
  end 

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to stocks_path
    else
      flash[:message] = "Sorry, please try again."
      render :new
    end

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :uid)
    end
end
