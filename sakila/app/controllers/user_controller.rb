class UserController < ApplicationController
  def sign_in
    if request.post?
      @user = User.where(user_params).first_or_create!
    
      # use session to maintain signed in state
      session[:user_id] = @user.id

      # check if we should redirect to some place interesting
      redirect_to(session.delete(:after_sign_in_uri) || blazer.root_path)
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
