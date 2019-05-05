class User < ApplicationRecord
  has_one :profile

  validates_presence_of :email, :uuid, :display_name
  validates_uniqueness_of :email, :uuid, :display_name 
end
