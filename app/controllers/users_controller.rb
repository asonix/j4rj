class UsersController < ApplicationController
  before_action :require_user
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
      redirect_to "/profile/#{@user.username}"
    end
  end

  def show
    @user = User.find_by(username: params[:id])
  end

  def edit
    @user = User.find_by(username: params[:id])
    @permissions = @user.permissions.pluck(:name).join(',')
  end

  def update
    @user = User.find_by(username: params[:id])
    @permissions = @user.permissions.pluck(:name).join(',')

    case params[:form_type]
    when 'general'
      params[:form_type] = nil
      if @user.update(general_params)
        redirect_to user_path(@user)
      else
        render 'edit'
      end
    when 'password'
      params[:form_type] = nil
      @current_user = User.find(session[:user_id])
      if @current_user.authenticate(params[:user][:current_password])
        if @user.update(password_params)
          redirect_to user_path(@user)
        else
          render 'edit'
        end
      else
        render 'edit'
      end
    when 'permissions'
      Role.delete(@user.role_ids)
      params['permissions'].split(',').each do |x|
        puts "ADDING #{x} TO USER"
        @user.roles.create(permission: Permission.find_by(name: x))
      end
      @user.save
      redirect_to "/profile/#{@user.username}"
    else
      render 'edit'
    end
  end

  def destory
    @user = User.find_by(params[:username])
    @user.destroy

    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :image, :password, :password_confirmation)
  end
  def general_params
    params.require(:user).permit(:email, :image, :permissions)
  end
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
