class LabelsController < ApplicationController
  before_action :set_label, only: [:edit, :update, :destroy]
  before_action :require_login  

  def index
    @labels = current_user.labels
  end

  def new
    @label = current_user.labels.build
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      flash[:notice] = 'Label has been created.'
      redirect_to labels_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      flash[:notice] = 'Updated labels'
      redirect_to labels_path
    else
      render :edit
    end
  end

  def destroy
    if @label.destroy
      flash[:notice] = 'Labels have been removed'
    end
    redirect_to labels_path
  end

  private

  def set_label
    @label = current_user.labels.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end