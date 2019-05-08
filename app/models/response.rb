class Response < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :body 
  validates_uniqueness_of :uuid
end
