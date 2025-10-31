class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to @task
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = 'Task was successfully updated.'
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task was successfully destroyed.'
    redirect_to tasks_url, status: :see_other
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
