class Profile < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :requests, dependent: :destroy

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :gender, :gender_seeking, 
                        :bio, :race, :location
  validates_uniqueness_of :uuid 

  enum gender: { man: 0, woman: 1, 'non-binary': 3 }
  enum gender_seeking: { men: 0, women: 1, both: 2}
  enum race: { 
    asian: 0, 'black/african': 1, caucasian: 2, 'hispanic/latino': 3, 
    'native american': 4, 'pacific islander': 5, 'mixed race': 6, 
    other: 7 
  }

end
