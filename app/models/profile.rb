class Profile < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, through: :questions
  has_many :views, dependent: :destroy
  has_many :requests, dependent: :destroy

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :gender, :gender_seeking, 
                        :bio, :race, :location, :looking_for
  validates_uniqueness_of :uuid 

  before_create :set_location

  enum gender: { man: 0, woman: 1, 'non-binary': 3 }
  enum gender_seeking: { men: 0, women: 1, both: 2}
  enum race: { 
    asian: 0, 'black/african': 1, caucasian: 2, 'hispanic/latino': 3, 
    'native american': 4, 'pacific islander': 5, 'mixed race': 6, 
    other: 7 
  }
  enum looking_for: { dating: 0, relationships: 1, either: 2 }

  def self.cached_with_questions
    Rails.cache.fetch('profiles_with_questions', force: true) { Profile.includes(:questions) }
  end 

  def self.update_cached_with_questions
    Rails.cache.write('profiles_with_questions', Profile.includes(:questions))
  end

  def self.cached_users_views_and_requests
    Rails.cache.fetch('profiles_with_users_and_views', force: true) { Profile.includes(:user, :views, :requests) }
  end 

  def self.update_cached_users_views_and_requests
    Rails.cache.write('profiles_with_users_and_views', Profile.includes(:user, :views, :requests))
  end  

  def user_submitted_response(user_id)
    self.questions.first.responses.find_by(user_id: user_id).present?
  end 

  def create_questions(question_params)
    self.questions << Question.new(body: question_params[:question1])
    self.questions << Question.new(body: question_params[:question2])
  end 

  private

  def set_location
    result = Geocoder.search(self.location).select { |result| result.country == 'USA'}

    self.location = result.blank? ? self.location : "#{result.first.data['address']['county']}, #{result.first.data['address']['state']}"
  end 
end
