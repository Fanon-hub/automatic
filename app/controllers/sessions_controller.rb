class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :logout_required, only: [:new, :create]  # Prevents logged-in users from accessing login page

  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.downcase)  # Recommended: downcase email

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil  # Clear memoized current_user
    redirect_to new_session_path, notice: "ログアウトしました"
  end
end