class Profiles::UpdateCacheProcess
  include Interactor::Organizer

  organize Profiles::UpdateCachedWithQuestions,
           Profiles::UpdateCachedUsersViewsAndRequests

end 