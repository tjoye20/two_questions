class Requests::UpdateProcess
  include Interactor::Organizer

  before do 
    if [context.request_id, context.request_state].any?(&:blank?)
      context.fail!(error: "Bad context in Requests::UpdateProcess. Context: #{context}")
    end 
  end 

  organize Requests::Update,
           Conversations::Create
           Requests::SetRedirectPath
           Messages::SetIntroduction

end 