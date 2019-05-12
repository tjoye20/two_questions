class View < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  validates_presence_of :state
end
