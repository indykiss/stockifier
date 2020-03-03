
class SessionsController < ApplicationController
  helper_method :current_user 

  def new
    @user = User.new
  end

  def sign_in
  end 

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
       sessions[:user_id] = @user.id
       redirect_to '/'
    else
       redirect_to '/signin'
       flash[:alert] = "Sorry, please try to sign up."
    end
  end

  def destroy
    log_out
    redirect_to '/'
  end

  def log_out
    reset_session
    @current_user = nil
  end

end
