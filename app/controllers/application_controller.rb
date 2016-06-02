class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_subscribed?
  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end

end
