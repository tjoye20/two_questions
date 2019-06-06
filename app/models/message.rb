class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validate :create_uuid, on: :create
  validates_presence_of :body, :conversation_id, :user_id, :uuid

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
