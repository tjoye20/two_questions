class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def index
    @profiles = Profile.includes(:user).where(gender: [current_user.profile.gender_seeking])
  end 

  def new
    @profile = Profile.new(user_id: current_user.id)
  end 

  def create
    profile = Profile.new(profile_params.merge({user_id: current_user.id}))

    if profile.save
      redirect_to user_profile_path(user_id: current_user.uuid, id: profile.uuid), success: 'Profile successfully created!'
    else
      redirect_to new_user_profile_path(current_user.uuid), alert: "Error saving profile: #{profile.errors.full_messages}"
    end 
  end  

  private

  def set_profile
    @profile = current_user.profile
  end 

  def profile_params
    params.require(:profile).permit(
      :gender, :gender_seeking, :bio, 
      :race, :location
    )
  end 
end