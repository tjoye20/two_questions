class Profile < ApplicationRecord
  belongs_to :user

  validates_presence_of :uuid, :gender, :gender_seeking, 
                        :bio, :race, :location, 
                        :first_name, :last_name
  validates_uniqueness_of :uuid 

  enum gender: { male: 0, female: 1, 'transgender-male': 2, 'transgender-female': 3, 'non-binary': 4 }

end
