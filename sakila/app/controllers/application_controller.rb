class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_user, except: %i(sign_in)

  def ensure_user
    return true if current_user

    session[:after_sign_in_uri] = request.headers['REQUEST_URI']
    # IMPORTANT: must reference base application since this maybe called in the
    # context of Blazer
    redirect_to Rails.application.routes.url_helpers.sign_in_path
    false
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
