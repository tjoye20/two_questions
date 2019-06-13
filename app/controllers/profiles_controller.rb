class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :check_if_profile_and_questions_exist, only: [:index, :show]
  before_action :set_cloudfront_url, only: [:index, :show]

  def index
    gender_seeking = current_user.profile.gender_seeking_before_type_cast == 2 ? ['man', 'woman'] : current_user.profile.gender_seeking_before_type_cast
    @profiles = Profile.includes(:user, :views).where("views.user_id != #{current_user.id}").references(:views).where(gender: gender_seeking)
  end 

  def show
    @profile = Profile.includes(:questions).find_by_uuid(params[:id])
    @questions = @profile.questions.pluck(:id, :body)
  end 

  def create
    result = Profiles::CreateProcess.call(profile_params: profile_params.merge({user_id: current_user.id}))

    if result.success?
      redirect_to new_profile_question_path(result.profile.uuid), notice: 'Profile created. Now create your profile questions.'
    else
      flash[:alert] = result.error
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

  def set_cloudfront_url
    @cloud_front_url = ENV['AMAZON_CLOUDFRONT_DOMAIN']
  end 
end