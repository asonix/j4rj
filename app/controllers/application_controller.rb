class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper ApplicationHelper
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def require_admin
    redirect_to '/' unless current_user.has_permission?('admin')
  end

  def require_editor
    redirect_to '/' unless current_user.has_permission?('editor')
  end

  def require_tester
    redirect_to '/' unless current_user.has_permission?('tester')
  end

  def require_permission(permission)
    redirect_to '/' unless current_user.has_permission?(permission)
  end

end
