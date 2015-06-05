class IndividualUsersController < ApplicationController
  before_action :require_user, except: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      puts 'failed'
      puts params
      redirect_to '/signup'
    end
  end


  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])

    case params[:form_type]
    when 'general'
      params[:user].delete(:form_type)
      if @user.update_attributes(general_params)
        redirect_to '/profile'
      else
        render 'individual_users/edit'
      end
    when 'password'
      params[:form_type] = nil
      if @user.authenticate(params[:user][:current_password])
        if @user.update(password_params)
          redirect_to '/profile'
        else
          render 'individual_users/edit'
        end
      else
        render 'individual_users/edit'
      end
    else
      render 'individual_users/edit'
    end
  end

  def destory
    @user = User.find(session[:user_id])
    @user.destroy

    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  def general_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :image)
  end
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
