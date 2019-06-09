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
    state :read 

    event :read do 
      transition new: :read
    end 

    event :reject do
      transition any => :rejected
    end

    event :approve do 
      transition any => :approved
    end 
  end 

  private

  def restrict_multiple_requests
    unless Request.where(user_id: self.user_id, profile_id: self.profile_id).or(Request.where(user_id: Profile.find_by_user_id(self.profile_id)&.user&.id, profile_id: self.profile_id)).blank?
      self.errors.add(:request, "already exists between you and this user.\nCheck your requests.")
    end
  end 
end
