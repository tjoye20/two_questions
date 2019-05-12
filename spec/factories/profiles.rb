FactoryBot.define do
  factory :profile do
    uuid { "MyString" }
    association :user
    gender { 1 }
    gender_seeking { 2 }
    bio { "MyText" }
    race { 1 }
    location { "MyString" }
    images { "" }
  end
end
