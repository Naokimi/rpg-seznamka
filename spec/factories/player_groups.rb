FactoryBot.define do
  factory :player_group do
    user { association :user }
    group { association :group }
  end
end
