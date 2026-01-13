class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]
  before_action :require_logout, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "You are registered."
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    @user.email.downcase! if user_params[:email]
    if @user.save
      redirect_to user_path, notice: "Your account has been updated."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end
end