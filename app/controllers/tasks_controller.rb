class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(10)
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

  # def create
  #   @task = Task.new(task_params)
  #   if @task.save
  #     flash[:notice] = 'Task was successfully created.'
  #     redirect_to tasks_url  # To index ("Tasks Index Page")
  #   else
  #     render :new, status: :unprocessable_entity  # Stays on new ("New Task Page") with errors
  #   end
  # end

  # def update
  #   @task = Task.find(params[:id])
  #   if @task.update(task_params)
  #     flash[:notice] = 'Task was successfully updated.'
  #     redirect_to @task  # To show ("Show Task Page")
  #   else
  #     render :edit, status: :unprocessable_entity  # Stays on edit ("Edit Task Page")
  #   end
  # end

  # def destroy
  #   @task = Task.find(params[:id])
  #   @task.destroy
  #   flash[:notice] = 'Task was successfully destroyed.'
  #   redirect_to tasks_url, status: :see_other
  # end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end
end

def create
  @task = Task.new(task_params)
  if @task.save
    redirect_to @task, notice: t('flash.tasks.create.notice')
  else
    render :new
  end
end

def update
  if @task.update(task_params)
    redirect_to @task, notice: t('flash.tasks.update.notice')
  else
    render :edit
  end
end

def destroy
  @task.destroy
  redirect_to tasks_path, notice: t('flash.tasks.destroy.notice')
end