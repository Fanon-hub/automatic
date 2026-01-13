class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in."
    end
  end

  def require_logout
    if logged_in?
      redirect_to tasks_path, alert: "Please log out."
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to tasks_path, alert: "You are not authorized."
    end
  end
end