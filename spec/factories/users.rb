FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@dnd.rpg" }
    password { 'password' }
  end

  trait :with_preference do
    after(:create) do |user|
      genre = create(:genre)
      user.genres << genre
    end
  end
end
