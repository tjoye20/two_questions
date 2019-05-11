class Question < ApplicationRecord
  belongs_to :profile

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :body, :state
  validates_uniqueness_of :uuid 

  def user
    self.profile.user
  end 
end
