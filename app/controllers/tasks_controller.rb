class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks

    # sorting
    @tasks = @tasks.deadline_asc  if params[:sort_deadline].present?
    @tasks = @tasks.priority_desc if params[:sort_priority].present?

    # searching
    if params[:search].present?
      @tasks = @tasks.where('title LIKE ?', "%#{params[:search][:title]}%") if params[:search][:title].present?
      @tasks = @tasks.where(status: params[:search][:status]) if params[:search][:status].present?

      if params[:search][:label_id].present?
        @tasks = @tasks.joins(:labels).where(labels: { id: params[:search][:label_id] })
      end
    end

    @tasks = @tasks.page(params[:page])
  end


  
  def new
    @task = current_user.tasks.new 
  end
  
  def show
  end

  def create
    @task = current_user.tasks.new(task_params) 
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy 
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end

  def correct_user_task
    unless current_user == @task.user
      redirect_to tasks_path, alert: 'You are not authorized.'
    end
  end
  def task_params
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, label_ids: [])
  end
end