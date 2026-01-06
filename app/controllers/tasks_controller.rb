class TasksController < ApplicationController
  before_action :login_required
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_task, only: [:show, :edit, :update, :destroy]
  
  def index
    tasks = Task.all

    
    tasks = tasks.latest          if params[:sort_created_at].present?
    tasks = tasks.deadline_asc    if params[:sort_deadline_on].present?
    tasks = tasks.priority_desc   if params[:sort_priority].present?
    
    if params[:search].present?
      tasks = tasks.search(params[:search])
    end

    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @task = current_user.tasks.new 
  end
  
  def show
  end

  def create
    @task = current_user.tasks.new(task_params) 
    if @task.save
      redirect_to tasks_path, notice: 'タスクが登録されました'
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクが更新されました'
    else
      render :edit
    end
  end

  def destroy 
    @task.destroy
    redirect_to tasks_path, notice: 'タスクが削除されました'
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end

  def correct_user_task
    unless current_user == @task.user
      redirect_to tasks_path, alert: 'アクセス権限がありません'
    end
  end
  def task_params
    params.require(:task).permit(:title, :content)
  end
end