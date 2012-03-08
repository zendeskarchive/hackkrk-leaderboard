class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user

  def authenticate_user
    @current_user = User.find_by_id(session[:user_id])
    redirect_to '/login' unless @current_user
  end

  def is_admin?
    redirect_to '/puzzles' unless current_user.admin?
  end

  def current_user
    @current_user
  end
  helper_method :current_user

end
