class UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:show]

  def new
    @user = User.new
    @permissions = Permission.all
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
    @permissions = Permission.all
  end

  def update
    @user = User.find(params[:id])

    case params[:form_type]
    when 'general'
      if @user.update(general_params)
        redirect_to user_path(@user)
      else
        render 'edit'
      end
    when 'password'
      @current_user = User.find(session[:user_id])
      if @current_user.authenticate(params[:password])
        @User.password = new_password
      else
        render 'edit'
      end
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
    params.require(:user).permit(:username, :first_name, :last_name, :email, :image, :password, :password_confimation, :permissions)
  end
  def general_params
    params.require(:user).permit(:email, :image, :form_type, :permissions)
  end
end
