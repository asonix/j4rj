class SessionsController < ApplicationController
  def new
    @login = "Login"
  end

  def create
    @user = User.find_by_username(params[:session][:username])
    if @user and @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
