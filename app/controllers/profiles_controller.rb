class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :check_if_profile_and_questions_exist, only: [:index, :show]

  def index
    gender_seeking = current_user.profile.gender_seeking_before_type_cast == 2 ? ['man', 'woman'] : current_user.profile.gender_seeking_before_type_cast
    @profiles = Profile.includes(:user, :questions).where(gender: gender_seeking).with_attached_images
  end 

  def show
    @profile = Profile.includes(:questions).with_attached_images.find_by_uuid(params[:id])
  end 

  def create
    profile = Profile.new(profile_params.merge({user_id: current_user.id}))
    
    if profile.save
      redirect_to new_profile_question_path(profile.uuid), notice: 'Profile successfully created.'
    else
      flash[:alert] = profile.errors.full_messages.join(', ')
      redirect_back(fallback_location: root_path)
    end 
  end 

  def update
    if @profile.update(profile_params)
      redirect_to root_path, notice: 'Profile successfully updated.'
    else
      flash[:alert] = @profile.errors.full_messages.join(', ')
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
      :race, :location, images: []
    )
  end 
end