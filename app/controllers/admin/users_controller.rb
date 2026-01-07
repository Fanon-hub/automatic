class Admin::UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @users = User.includes(:tasks).all # N+1 fix
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)
    @user.email.downcase!
    if @user.save
      redirect_to admin_users_path, notice: "You have registered a user"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(admin_user_params)
    @user.email.downcase! if admin_user_params[:email]
    if @user.save
      redirect_to admin_users_path, notice: "Updated users"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "You have deleted a user"
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end