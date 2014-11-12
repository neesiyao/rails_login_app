class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  def logged_in_user
      redirect_to login_url, flash: { danger: "Please log in" } unless logged_in?
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to root_url unless @user == current_user || current_user.examiner? || current_user.admin?
  end

  def admin_user
    redirect_to root_url, flash: { danger: "Access denied" } unless current_user.admin?
  end

  def examiner_user
    redirect_to root_url, flash: { danger: "Access denied" } unless current_user.examiner? || current_user.admin?
  end
end
