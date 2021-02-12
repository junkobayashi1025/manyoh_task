class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # before_action :current_user

  def authenticate_user
    if current_user == nil
      flash[:notice] = "ログインが必要です！"
      redirect_to new_session_path
    end
  end

  def current_user?
    @user = User.find(params[:id])
    if @user != current_user
      flash[:notice] = "閲覧権限がありません"
      redirect_to tasks_path
    end
  end
end
