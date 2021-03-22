FactoryBot.define do
  factory :rulebook do
    name { "MyString" }
    description { "MyTextDescription" }
    association :genre
  end
end
