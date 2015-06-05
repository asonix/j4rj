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
      if @current_user.authenticate(params[:current_password])
        if @current_user.update(password_prams)
          redirect_to user_path(@user)
        else
          render 'edit'
        end
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destory
    @user = User.find(session[:user_id])
    @user.destroy

    redirect_to '/'
  end

  private
  def user_params
    params.require(:individual_user).permit(:username, :email, :password, :password_confirmation)
  end
  def general_params
    params.require(:individual_user).permit(:username, :email, :image, :form_type, :permissions)
  end
  def password_params
    params.require(:individual_user).permit(:password, :password_confirmation)
  end
end
