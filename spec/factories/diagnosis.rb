FactoryBot.define do
  factory :diagnosis do
    association :user
    association :keyboard
  end
end
