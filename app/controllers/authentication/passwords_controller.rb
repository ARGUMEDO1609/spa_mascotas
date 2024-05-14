class Authentication::PasswordsController < ApplicationController

  def edit
  end

  def update
    if current_user.update(password_params)
      redirect_to root_path, notice: "Password update"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:password).permit(
      :password,
      :password_confirmation,
      :password_challenge
   ).with_defaults(password_challenge: "")
  end
end
