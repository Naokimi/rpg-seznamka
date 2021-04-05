FactoryBot.define do
  factory :rulebook do
    name { "MyString" }
    description { "MyTextDescription" }
    img_url { "MyImageUrl.jpg"}
  end

  trait :with_genre do
    after(:create) do |rulebook|
      genre = create(:genre)
      rulebook.genres << genre
    end
  end
end
