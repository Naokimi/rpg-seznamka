FactoryBot.define do
  factory :rulebook do
    name { "MyString" }
    description { "MyTextDescription" }
    img_url { "MyImageUrl"}
    association :genre
  end
end
