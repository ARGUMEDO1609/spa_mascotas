class Authentication::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by("email = :login OR username = :login", {login: params[:login] })
    if @user.authenticate(params[:password])
      login @user
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash[:alert] = "Invalid login credential"
      render :new, status: :unprocessible_entity
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: "Logged out successfully"
  end
end
