FactoryBot.define do
  factory :user do
    uuid { "MyString" }
    sequence (:email) { |n| "#{SecureRandom.hex}@gmail.com" }
    image { "MyString" }
    sequence (:display_name) { |n| "RHAAAD7#{SecureRandom.hex}" }
    state { "MyString" }
  end
end
