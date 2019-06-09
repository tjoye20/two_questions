class Messages::SetIntroduction
  include Interactor

  before do 
    if context.request.blank?
      context.fail!(error: "Bad context in Messages::SetIntroduction. Context: #{context}")
    end 

    set_profiles 
  end 

  def call
    return if context.conversation.blank?
    @profiles.each do |profile| 
      create_introduction_messages(profile, profile.questions)
    end 
  end 

  def rollback
    context.conversation.messages.destroy_all
  end 

  private

  def set_profiles
    return if context.conversation.blank?
    @profiles = Profile.includes(:questions).where(user_id: [context.conversation.sender_id, context.conversation.recipient_id])
  end

  def create_introduction_messages(profile, questions)
    responding_user_id = context.conversation.sender_id == profile.user_id ? context.conversation.recipient_id : context.conversation.sender_id
    mg_sender_id = context.conversation.sender_id == responding_user_id ? context.conversation.recipient_id : context.conversation.sender_id

    questions.each do |question|
      #Question
      Message.create!(
        conversation_id: context.conversation.id, 
        user_id: mg_sender_id,
        body: question.body
      )
      #Response
      Message.create!(
        conversation_id: context.conversation.id, 
        user_id: responding_user_id,
        body: Response.find_by(question_id: question.id, user_id: responding_user_id).body
      )
    end 
  end 
end 