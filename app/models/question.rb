class Question < ApplicationRecord
  belongs_to :profile
  has_many :responses

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :body, :state
  validates_uniqueness_of :uuid 
  validates_length_of :body, maximum: 40

  state_machine :state, initial: :active do 
    event :archive do 
      transition any => :archived
    end 
  end 

  def user
    self.profile.user
  end 
end
