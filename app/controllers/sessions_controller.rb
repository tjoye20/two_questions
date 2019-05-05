class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
    if current_user
      redirect_to profiles_path, notice: 'Welcome ' + current_user.display_name + '!'
    end
  end

  def destroy
    session[:user_uuid] = nil
    redirect_to root_path, :alert => "Logged out!"
  end
end