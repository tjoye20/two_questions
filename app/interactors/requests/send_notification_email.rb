class Requests::SendNotificationEmail
  include Interactor

  before do 
    if [context.user_id, context.profile_id ].any?(&:blank?)
      context.fail!(error: "Bad context in Requests::SendNotificationEmail. Context: #{context}")
    end 
  end 

  def call
    RequestsMailer.with(user_id: context.user_id, profile_id: context.profile_id).notification.deliver_now
  end 
end 