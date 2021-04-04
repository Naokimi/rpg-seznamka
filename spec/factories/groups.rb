FactoryBot.define do
  factory :group do
    name { "MyString" }
    description { "Join My Group, I have no Friends" }
    train_station { "MyString" }
    gm { association :user }
  end
end
