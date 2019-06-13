class InterestsController < ApplicationController

  def index
    @profiles = Profile.cached_users_and_views.where(views: { user_id: current_user.id, state: 'approved'  })
    
    if @profiles.empty?
      redirect_to root_path, notice: 'You do not have any interests right now.'
    end 
  end 
end