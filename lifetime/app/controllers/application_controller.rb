class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :user_login, :redirect_user, :logged_in?, :logout, :current_user

  def user_login(user)
    session[:id] = user.id
  end

  def redirect_user
    redirect "/home" if current_user
  end

  def logged_in?
    current_user.nil?
  end

  def logout
    session.clear
    redirect '/home'
  end

  def current_user
    @current_user ||= User.find(id: session[:id])
  end

end
