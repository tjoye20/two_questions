FactoryBot.define do
  factory :response do
    association :user
    association :question
    body { "MyText" }
  end
end
