class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:show, :edit, :update]
  before_action :correct_user,    only: [:show, :edit, :update]
  before_action :admin_user,      only: [:index, :destroy]

  def show
    @user = User.find_by_id(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, flash: { success: "You have successfully created an account" }
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, flash: { success: "Profile successfully updated" }
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by_id(params[:id]).destroy
    redirect_to users_url, flash: { success: "User deleted" }
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in_user
        redirect_to login_url, flash: { danger: "Please log in" } unless logged_in?
    end

    def correct_user
      @user = User.find_by_id(params[:id])
      redirect_to root_url unless @user == current_user || current_user.admin?
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
