class UsersController < ApplicationController
  skip_before_action :authenticate_user

  def create
    redirect_to new_session_path if params[:denied] 
    find_or_create_user
    session[:user_uuid] = @user.uuid
    determine_login_path
  end

  private

  def determine_login_path
    notice_msg = 'Welcome ' + @user.display_name + '!'

    if @user.profile 
      redirect_to profiles_path, notice: notice_msg
    else
      redirect_to new_user_profile_path(@user.uuid), notice: notice_msg
    end 
  end 

  def find_or_create_user
    unless @user = User.find_by(email: auth_hash&.info&.email)
      @user = create_user
    end
  end 

  def create_user
    User.create\
      email: auth_hash.info.email, 
      image: auth_hash.info.image,
      display_name: auth_hash.info.name 
  end 

  def auth_hash
    request.env['omniauth.auth']
  end
end