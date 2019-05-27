class Request < ApplicationRecord
  belongs_to :user
  belongs_to :profile
  has_many :questions, through: :profile
  has_many :responses, through: :profile

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :state 
  validates_uniqueness_of :uuid

  state_machine :state, initial: :new do
    event :reject do
      transition any => :rejected
    end

    event :approve do 
      transition any => :approved
    end 
  end 
end
