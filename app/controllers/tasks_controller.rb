class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all
    @tasks = @tasks.latest if params[:sort_created_at]
    @tasks = @tasks.deadline_asc if params[:sort_deadline_on]
    @tasks = @tasks.priority_desc if params[:sort_priority]
    
    if params[:search].present?
      @tasks = @tasks.search(params[:search])
    end
    
    @tasks = @tasks.page(params[:page])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクが登録されました'
    else
      render :new
    end
  end
  
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクが更新されました'
    else
      render :edit
    end
  end
  
  private
  
  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end