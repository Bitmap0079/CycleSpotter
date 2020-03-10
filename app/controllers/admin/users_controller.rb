class Admin::UsersController < ApplicationController
  before_action :require_admin, only: [:edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました！"
    else
      render :new, flash: { error: @user.errors.full_messages }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を登録しました！"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destoy
    redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.name}」を削除しました！"
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

end
