class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :current_user

  def authenticate_user
    if current_user.nil?
    flash[:notice] = "ログインが必要です！"
    redirect_to new_session_path
    end
  end

  def user_admin?
    unless current_user.admin?
      flash[:danger] = "権限がありません"
      redirect_to tasks_path
    end
  end
end
