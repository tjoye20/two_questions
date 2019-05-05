FactoryBot.define do
  factory :profile do
    uuid { "MyString" }
    user { nil }
    gender { 1 }
    gender_seeking { 1 }
    bio { "MyText" }
    race { 1 }
    location { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    images { "" }
  end
end
