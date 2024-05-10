class ApplicationController < ActionController::Base
  around_action :switch_local

  def switch_local(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

  def authenticate_user!
    redirect_to root_path, alert: "You must be logged in to do thad" unless user_signed_in?
  end

  def current_user
      Current.user ||= authenticate_user_from_session
  end

  helper_method :current_user, :user_signed_in?

  def user_signed_in?
    self.current_user.present?
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end

  def locale_from_header
   request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}/)&.first
  end
end
