class View < ApplicationRecord
  belongs_to :profile
  belongs_to :user

  validates_presence_of :state

  state_machine :state do
    event :rejected do
      transition any => :rejected
    end

    event :interested do 
      transition any => :interested
    end 
  end 
end
