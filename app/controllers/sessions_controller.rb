class SessionsController < ApplicationController
  before_action :require_logout, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: "I have logged in"
    else
      flash.now[:alert] = "Your email address or password is incorrect"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to login_path, notice: "logged out"
  end
end