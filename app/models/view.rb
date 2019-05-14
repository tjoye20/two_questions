class View < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  validates_presence_of :state
  validate :restrict_views_per_profile, on: :create

  private

  def restrict_views_per_profile
    unless View.find_by(profile_id: self.profile_id, user_id: self.user_id).nil?
      self.errors.add(:profile, 'can not be rated twice.')
    end 
 end
end
