FactoryBot.define do
  factory :pairing do
    genre { association :genre }
    rulebook { association :rulebook }
  end
end
