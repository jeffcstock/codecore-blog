class PasswordsController < ApplicationController
  def edit
    @password = params.dig :user, :password
    @user = current_user
  end
  def update
    @user = current_user
    current_password = params.dig(:user, :current_password)
    user_params = params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation])
    if @user && @user.authenticate(current_password)
      if @user.update user_params
        redirect_to root_path, notice: 'Password updated'
      else
        render :edit, notice: 'Password not updated'
      end
    end
  end

  private

  def password_no_match
    render :edit, notice: 'Password not updated'
  end
end
