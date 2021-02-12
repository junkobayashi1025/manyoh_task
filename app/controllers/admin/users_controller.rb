class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_url(@user)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_user_url
    flash[:danger] = "ユーザー「#{@user.name}」を削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

end
