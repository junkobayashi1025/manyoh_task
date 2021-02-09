class TasksController < ApplicationController
  def index
    if params[:sort_expired] || params[:sort_priority]
      if params[:sort_expired]
        @tasks = Task.all.order(deadline: :desc)
      elsif params[:sort_priority]
        @tasks = Task.all.order(priority: :desc)
      end
    else
      @tasks = Task.all.order(created_at: :desc)
    end

     if params[:title].present? && params[:status].present?
       @tasks = Task.title_search(params[:title]).status_search(params[:status])
     elsif params[:title].present?
       @tasks = Task.title_search(params[:title])
     elsif params[:status].present?
       @tasks = Task.status_search(params[:status])
     end
   end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.title}」を登録しました"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.title}」を更新しました"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.title}を削除しました」"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

end
