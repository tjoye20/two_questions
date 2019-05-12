class ViewsController < ApplicationController
  before_action :set_profile

  def create
    view = View.new(user_id: current_user.id, profile_id: @profile.id, state: views_params[:state])
    
    if view.save
      head :created
    else
      render json: { errors: view.errors.full_messages }, status: :unprocessable_entity
    end 
  end

  private

  def set_profile
    @profile = Profile.find_by_uuid(params[:profile_id])
  end 

  def views_params
    params.require(:view).permit(:profile_id, :state)
  end 
end