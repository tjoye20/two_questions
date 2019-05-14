class Response < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validate :create_uuid, on: :create
  validates_presence_of :uuid, :body 
  validates_uniqueness_of :uuid

  def self.create_question_responses(response_params)
    return unless Response.where(user_id: response_params[:user_id], question_id: [response_params[:question1_id], response_params[:question2_id]]).empty?
    Response.create!(user_id: response_params[:user_id], question_id: response_params[:question1_id], body: response_params[:response1])
    Response.create!(user_id: response_params[:user_id], question_id: response_params[:question2_id], body: response_params[:response2])
  end 
end
