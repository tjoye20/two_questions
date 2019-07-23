class Profiles::UpdateCachedWithQuestions
  include Interactor

  def call
    Profile.update_cached_with_questions
  end 
end 