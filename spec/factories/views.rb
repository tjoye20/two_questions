FactoryBot.define do
  factory :view do
    association :profile
    association :user
  end
end
