class UsersController < ApplicationController
  before_action :current_user?, only: [:show]
  def new
    if current_user.present?
    flash[:notice] = "閲覧権限がありません"
    redirect_to tasks_path
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
     render :new
    end
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:danger] = "ユーザー「#{@user.name}」を削除しました"
    redirect_to new_user_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def current_user?
    @user = User.find(params[:id])
    if @user != current_user
    flash[:notice] = "閲覧権限がありません"
    redirect_to tasks_path
    end
  end
end
