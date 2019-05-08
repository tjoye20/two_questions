class Question < ApplicationRecord
  belongs_to :profile
  belongs_to :user, through: :profile

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :body, :state
  validates_uniqueness_of :uuid 
end
