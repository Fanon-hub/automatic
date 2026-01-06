module Admin
  class UsersController < ApplicationController
    before_action :admin_required
    
    def index
      @users = User.includes(:tasks).all  # Eager loading to avoid N+1
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(admin_user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'ユーザーを登録しました'
      else
        render :new
      end
    end
    
    def show
      @user = User.includes(tasks: [:user]).find(params[:id])
    end
    
    def edit
      @user = User.find(params[:id])
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update(admin_user_params)
        redirect_to admin_users_path, notice: 'ユーザーを更新しました'
      else
        render :edit
      end
    end
    
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    end
    
    private
    
    def admin_required
      unless current_user&.admin?
        redirect_to tasks_path, alert: '管理者のみアクセスできます'
      end
    end
    
    def admin_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
  end
end