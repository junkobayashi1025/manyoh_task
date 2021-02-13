class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_admin?

  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー「#{@user.name}」を登録しました"
      redirect_to admin_user_url(@user)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_url(@user)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました"
    else
    flash[:notice] = "少なくとも1人、管理権限をもつユーザーが必要の為、更新できません。"
    redirect_to admin_users_path
    end
  end

  def destroy
    if @user.destroy
    redirect_to admin_users_url
    flash[:danger] = "ユーザー「#{@user.name}」を削除しました"
    else
    flash[:notice] = "少なくとも1人、管理権限をもつユーザーが必要の為、削除できません。"
    redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

end
