class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:show, :edit, :update]
  before_action :correct_user,    only: [:show, :edit, :update]
  before_action :admin_user,      only: [:destroy, :new]
  before_action :examiner_user,   only: [:index, :new]

  def show
    @user = User.find_by_id(params[:id])
    @invitations = Invitation.where(email: @user.email)
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
      redirect_to @user, flash: { success: "Account was successfully created" }
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    user = User.find_by_email(@user.email).try(:authenticate, params[:current_password])
    if user && @user.update_attributes(user_params)
      redirect_to @user, flash: { success: "Profile was successfully updated" }
    else
      flash[:danger] = "Please enter your current password"
      render 'edit'
    end
  end

  def destroy
    User.find_by_id(params[:id]).destroy
    redirect_to users_url, flash: { success: "User was successfully deleted" }
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
