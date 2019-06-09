class Requests::UpdateProcess
  include Interactor::Organizer

  #Someone makes a request to your PROFILE, so THEY are the USER. 
  #You are the one making the Requests#Update call.
  #We're now checking to see if you, the USER, have approved THEIR profile.

  before do 
    if [context.request_id, context.request_state].any?(&:blank?)
      context.fail!(error: "Bad context in Requests::UpdateProcess. Context: #{context}")
    end 
  end 

  organize Requests::Update,
           Conversations::Create,
           Requests::SetRedirectPath,
           Messages::SetIntroduction

end 