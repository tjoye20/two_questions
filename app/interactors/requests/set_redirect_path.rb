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
    url_helper = Rails.application.routes.url_helpers

    if context.conversation
      context.redirect_path = url_helper.conversation_path(context.conversation.uuid)
      context.notice = 'Match made! Start chatting today.'
    elsif context.request.approved? 
      context.redirect_path = url_helper.profile_path(context.request.user.profile.uuid)
      context.notice = 'Approved! Now submit your responses to their questions.'
    else
      context.redirect_path = url_helper.requests_path
      context.notice = 'Rejected.'
    end 
  end 
end 