class Conversations::Create
  include Interactor

  before do 
    if context.request.blank?
      context.fail!(error: "Bad context in Conversations::Create. Context: #{context}")
    end 
  end 

  def call
    if do_the_users_approve_each_others_profiles?
      create_conversation
    end 
  end 

  def rollback
    context.conversation.destroy
  end

  private

  def do_the_users_approve_each_others_profiles?
    return false if context.request.rejected?
    #Someone makes a request to your PROFILE, so THEY are the USER. You are the one making the Requests#Update call.
    #We're now checking to see if you, the USER, have approved THEIR profile.
    Request.find_by(state: 'approved', user_id: context.request.profile.user.id, profile_id: context.request.user.profile.id).nil? ? false : true
  end 

  def create_conversation
    context.conversation = Conversation.new(sender_id: context.request.profile.user.id, recipient_id: context.request.user.id)
  
    unless context.conversation.save
      context.fail!(error: 'Bad context in Conversations::Create. Failed to create conversation. Errors: ' + context.conversation.errors.join(', '))
    end 
  end 
end 