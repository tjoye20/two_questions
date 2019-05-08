FactoryBot.define do
  factory :request do
    user { nil }
    profile { nil }
    state { "MyString" }
  end
end
