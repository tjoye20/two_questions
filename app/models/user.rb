class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :questions, through: :profile
  has_many :requests, through: :profile, dependent: :destroy
  has_many :views, dependent: :destroy

  validate :create_uuid, on: :create
  validates_presence_of :email, :uuid, :display_name
  validates_uniqueness_of :email, :uuid, :display_name 
end
