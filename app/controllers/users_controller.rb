class UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destory
    @user = User.find(params[:id])
    @user.destroy

    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_verification, :roles)
  end
end
