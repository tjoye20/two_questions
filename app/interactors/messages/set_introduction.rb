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
      create_introduction(profile.questions)
    end 
  end 

  def rollback
    context.conversation.messages.destroy_all
  end 

  private

  def set_profiles
    @profiles = Profile.includes(:questions).where(user_id: [context.conversation.sender_id, context.conversation.recipient_id])
  end 

  def create_introduction(questions)
    questions.each do |question|
      create_messages(question)
    end 
  end 

  def create_messages(question)
    #Question
    Message.create!(
      conversation_id: context.conversation.id, 
      user_id: question.profile.user.id ,
      body: question.body
    )
    #Response
    Message.create!(
      conversation_id: context.conversation.id, 
      user_id: context.request.user_id,
      body: Response.find_by(question_id: question.id, user_id: context.request.user_id).body
    )
  end 
end 