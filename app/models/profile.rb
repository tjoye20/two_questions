class Profile < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, through: :questions
  has_many :views, dependent: :destroy
  has_many :requests, dependent: :destroy

  has_many_attached :images

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

  def user_submitted_response(user_id)
    self.questions.first.responses.find_by(user_id: user_id).present?
  end 

  def create_questions(question_params)
    self.questions << Question.new(body: question_params[:question1])
    self.questions << Question.new(body: question_params[:question2])
  end 

end
