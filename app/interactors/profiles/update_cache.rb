class Profiles::UpdateCache
  include Interactor

  before do 
    if context.profile.blank?
      context.fail!(error: "Bad context in Profiles::UpdateCache. Context: #{context}")
    end 
  end 

  def call
    Profile.update_cache
  end 
end 