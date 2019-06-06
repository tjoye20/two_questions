class ConversationsController < ApplicationController

  def index
    @conversations = current_user.conversations
  end 

  def show
    @conversation = Conversation.includes(:messages).find_by_uuid(params[:id])
  end
end