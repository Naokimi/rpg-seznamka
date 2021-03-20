FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@dnd.rpg" }
    password { 'password' }
  end
end
