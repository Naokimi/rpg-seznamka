FactoryBot.define do
  factory :group do
    name { "MyString" }
    description { "Join My Group, I have no Friends" }
    city { "MyString" }
    gm { association :user }
  end
end
