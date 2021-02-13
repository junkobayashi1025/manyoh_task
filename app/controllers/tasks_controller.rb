class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired] || params[:sort_priority]
      if params[:sort_expired]
        @tasks = Task.all.order(deadline: :desc).page(params[:page]).per(10)
      elsif params[:sort_priority]
        @tasks = Task.all.order(priority: :desc).page(params[:page]).per(10)
      end
    else
      @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
    end

     if params[:title].present? && params[:status].present?
       @tasks = Task.title_search(params[:title]).status_search(params[:status]).page(params[:page]).per(10)
     elsif params[:title].present?
       @tasks = Task.title_search(params[:title]).page(params[:page]).per(10)
     elsif params[:status].present?
       @tasks = Task.status_search(params[:status]).page(params[:page]).per(10)
     end
   end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = "タスク「#{@task.title}」を登録しました"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    flash[:success] = "タスク「#{@task.title}」を更新しました"
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    flash[:danger] = "タスク「#{@task.title}」を削除しました"
    redirect_to tasks_path
  end

  private
  def set_task
    if current_user.admin?
      @task = Task.find(params[:id])
    else
      @task = current_user.tasks.find(params[:id])
    end
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

end
