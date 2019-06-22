class ViewsController < ApplicationController
  before_action :set_profile

  def create
    view = View.new(user_id: current_user.id, profile_id: @profile.id, state: view_params[:state])

    if view.save
      ApprovedViewNotificationJob.perform_later(profile_id, current_user.id) if view_params[:state] == 'approved'
      head :created
    else
      render json: view.errors.full_messages.join(', '), status: :unprocessable_entity
    end 
  end

  def update
    view = View.find_by(profile_id: @profile.id, user_id: current_user.id)

    if view.update(state: view_params[:state])
      head :ok
    else
      render json: view.errors.full_messages.join(', '), status: unprocessable_entity
    end 
  end 

  private

  def set_profile
    @profile = Profile.find_by_uuid(view_params[:profile_id])
  end 

  def view_params
    params.permit(:profile_id, :state)
  end 
end