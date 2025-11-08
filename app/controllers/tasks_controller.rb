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

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: t('flash.tasks.create.notice')  # "タスクを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: t('flash.tasks.update.notice')  # "タスクを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: t('flash.tasks.destroy.notice')  # "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end
end