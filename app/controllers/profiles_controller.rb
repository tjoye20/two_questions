class ProfilesController < ApplicationController
  before_action :authenticate_user
  before_action :set_profile, only: [:edit, :update]

  def index
    @profiles = Profile.includes(:user).where(gender: [current_user.profile.gender_seeking])
  end 

  def new
    @profile = Profile.new(user_id: current_user.id)
  end 

  def create
    @profile = Profile.new(profile_params.merge({user_id: current_user.id}))

    if @profile.save
      redirect_to user_profile_path(@profile), success: 'Profile successfully created!'
    else
      redirect_to new_profile_path(current_user.uuid), alert: "Error saving profile: #{@profile.errors.full_messages}"
    end 
  end  

  def update

  end 

  private

  def set_profile
    @profile = current_user.profile
  end 

  def profile_params
    params.require(:profile).permit(
      :gender, :gender_seeking, :bio, 
      :race, :location, :first_name, 
      :last_name
    )
  end 
end