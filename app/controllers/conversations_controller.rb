class ConversationsController < ApplicationController

  def index
    @conversations = current_user.conversations
  end 

  def show
    @conversation = current_user.conversations.find_by_uuid(params[:conversation_uuid])
  end
end