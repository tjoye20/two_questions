class Requests::CreateProcess
  include Interactor::Organizer

  before do 
    if [context.response_params, context.user_id, context.profile_id ].any?(&:blank?)
      context.fail!(error: "Bad context in Requests::CreateProcess. Context: #{context}")
    end 
  end 

  organize Requests::Create,
           Requests::CreateResponse,
           Requests::SendNotificationEmail,
           UpdateCache

end 