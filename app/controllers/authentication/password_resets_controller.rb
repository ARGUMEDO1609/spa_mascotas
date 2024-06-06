class Authentication::PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    PasswordMailer.with(
      user: user,
      token: user.generate_token_for(:password_reset)
    ).password_reset.deliver_later if user.present?
    redirect_to root_path, notice: "Password reset instructions sent to your email."
  end

  def edit
  end

  def update
    if @user.update(password_params)
      redirect_to new_session_path, notice: "Password reset succesfully!. Please login"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path, alert: "Invalid token, please try again" unless @user.present?
  end
end
