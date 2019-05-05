class Profile < ApplicationRecord
  belongs_to :user

  validates_presence_of :uuid, :gender, :gender_seeking, 
                        :bio, :race, :location, 
                        :first_name, :last_name
  validates_uniqueness_of :uuid 

  enum gender: { man: 0, woman: 1, 'non-binary': 3 }

end
