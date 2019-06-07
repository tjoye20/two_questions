class Request < ApplicationRecord
  belongs_to :user
  belongs_to :profile
  has_many :questions, through: :profile
  has_many :responses, through: :profile

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :state 
  validates_uniqueness_of :uuid
  validate :restrict_multiple_requests, on: :create

  state_machine :state, initial: :new do
    event :reject do
      transition any => :rejected
    end

    event :approve do 
      transition any => :approved
    end 
  end 

  private

  def restrict_multiple_requests
    unless Request.where(user_id: self.user_id).or(Request.where(profile_id: Profile.find_by_user_id(self.user_id).id)).nil?
      self.errors.add(:request, "already exists between you and this user.\nCheck your requests.")
    end
  end 
end
