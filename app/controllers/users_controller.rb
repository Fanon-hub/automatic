class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]  # Allow signup when not logged in
  before_action :logout_required, only: [:new, :create]       # Optional: prevent signed-up while logged in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "アカウントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)  # Adjust fields as needed
  end
end