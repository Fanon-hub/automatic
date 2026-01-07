# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # This applies to all controllers by default
  before_action :login_required
  
  helper_method :current_user, :logged_in?
  
  private
  
  # Method being skipped in UsersController for new/create actions
  def login_required
    unless logged_in?
      redirect_to login_path, alert: "ログインしてください"
    end
  end
  
  # Method required for new/create actions in UsersController
  def logout_required
    if logged_in?
      redirect_to tasks_path, alert: "すでにログインしています"
    end
  end
  
  # Method used in correct_user check
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  # Helper method to check login status
  def logged_in?
    current_user.present?
  end
end