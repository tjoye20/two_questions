class Profiles::UpdateCachedUsersViewsAndRequests
  include Interactor

  def call
    Profile.update_cached_users_views_and_requests
  end 
end 