class ApplicationController < ActionController::Base
  protect_from_forgery


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
  def current_user_or_redirect
    if !current_user
      redirect_to login_path
      return false
    else
      return true
    end
  end
  helper_method :current_user_or_redirect

end
