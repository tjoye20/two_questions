class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def index
    gender_seeking = current_user.profile.gender_seeking_before_type_cast == 2 ? ['man', 'woman'] : current_user.profile.gender_seeking_before_type_cast
    @profiles = Profile.includes(:user, :questions).where(gender: gender_seeking)
  end 

  def show
    @profile = Profile.includes(:questions).find_by_uuid(params[:uuid])
  end 

  def create
    profile = Profile.new(profile_params.merge({user_id: current_user.id}))
    
    if profile.save
      redirect_to new_profile_questions_path(profile.uuid), notice: 'Profile successfully created.'
    else
      flash[:alert] = profile.error
      redirect_back(fallback_location: root_path)
    end 
  end 

  def update
    if @profile.update(profile_params)
      redirect_to root_path, notice: 'Profile successfully updated.'
    else
      flash[:alert] = @profile.error
      redirect_back(fallback_location: root_path)
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