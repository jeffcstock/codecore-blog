class PasswordsController < ApplicationController
  def edit
  end
  def update

    current_password = params[:old_password]
    return render password_no_match unless current_user.authenticate(current_password)
    @user.password = params.permit(:new_password)
    @user.password_confirmation = params.permit(:confirm_password)
    if @user.save
      redirect_to root_path, notice: 'User updated'
    else
      render :edit
    end
  end

  private

  def password_no_match
    render :edit, notice: 'Password not updated'
  end
end
