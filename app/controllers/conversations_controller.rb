class ConversationsController < ApplicationController

  def index
    @conversations = current_user.conversations

    if @conversations.empty?
      redirect_to root_path, alert: 'You do not have any conversations right now.'
    end
  end 

  def show
    @conversation = Conversation.includes(:messages).where(sender_id: current_user.id).or(Conversation.includes(:messages).where(recipient_id: current_user.id)).find_by_uuid(params[:id])
    
    if @conversation
      @conversation.update(state: 'read')
    else
      flash[:alert] = 'That conversation does not exist.'
      redirect_back(fallback_location: root_path)
    end 
  end
end