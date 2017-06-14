class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_user, except: %i(sign_in)

  def ensure_user
    redirect_to(sign_in_path) and return false unless current_user
  end

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end
  helper_method :current_user

  def blazer
    Blazer::Engine.routes.url_helpers
  end
  helper_method
end
