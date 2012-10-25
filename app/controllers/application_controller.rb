class ApplicationController < ActionController::Base
  protect_from_forgery
  

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    session[:return_to] = request.fullpath
    redirect_to login_path, notice: "Login first" unless !current_user.nil? 
  end

  helper_method :current_user
  
end
