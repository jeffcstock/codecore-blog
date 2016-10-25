class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end
  helper_method :authenticate_user!

  def current_user
    @user ||= User.find(session[:user_id])
  end
  helper_method :current_user
end
