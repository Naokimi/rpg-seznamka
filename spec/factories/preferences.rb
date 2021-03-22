FactoryBot.define do
  factory :preference do
    association :user
    association :genre
  end
end
