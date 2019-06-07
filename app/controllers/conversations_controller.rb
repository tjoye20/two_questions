class ConversationsController < ApplicationController

  def index
    @conversations = current_user.conversations

    if @conversations.empty?
      redirect_to root_path, notice: 'You do not have any conversations right now.'
    end
  end 

  def show
    @conversation = Conversation.includes(:messages).where(sender_id: current_user.id).or(Conversation.includes(:messages).where(recipient_id: current_user.id)).find_by_uuid(params[:id])
  end
end