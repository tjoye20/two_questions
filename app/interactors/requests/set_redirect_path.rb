class Requests::SetRedirectPath
  include Interactor

  before do 
    if context.request.blank?
      context.fail!(error: "Bad context in Requests::SetRedirectPath. Context: #{context}")
    end 
  end 

  def call
    set_redirect_path_and_notice
  end 

  private

  def set_redirect_path_and_notice
    if context.conversation
      context.redirect_path = conversation_path(context.conversation.uuid)
      context.notice = 'Match made! Start chatting today.'
    elsif context.request.approved? 
      context.redirect_path = profile_path(context.request.user.profile.uuid)
      context.notice = 'Approved! Now submit your responses to their questions.'
    else
      context.redirect_path = requests_path
      context.notice = 'Rejected.'
    end 
  end 
end 