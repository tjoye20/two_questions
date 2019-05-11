FactoryBot.define do
  factory :request do
    association :user
    association :profile
  end
end
