class UserController < ApplicationController
  def sign_in
    if request.post?
      @user = User.where(user_params).first_or_create!
      session[:user_id] = @user.id
      redirect_to blazer.root_path
    else
      @user = current_user || User.new
    end
  end

  def sign_out
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
