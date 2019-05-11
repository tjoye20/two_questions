FactoryBot.define do
  factory :question do
    association :profile
    body { "MyString" }
    state { "MyString" }
    uuid { "MyString" }
  end
end
