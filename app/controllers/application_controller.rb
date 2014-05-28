class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  before_action :banned?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  private
  def login!(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end
  
  def logout!
    session[:token] = nil
    @current_user = nil
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end
  
  def logged_in?
    !!current_user
  end

  def ensure_login!
    unless logged_in?
      flash[:notice] = "You must be logged in to do that"
      redirect_to root_url
    end
  end

  def banned?
    if logged_in? && current_user.banned
      flash[:errors] = ["You have been banned!  (You can not create or edit any threads or posts)"]
    end
  end
end

