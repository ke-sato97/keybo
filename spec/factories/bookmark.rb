FactoryBot.define do
  factory :bookmark do
    association :user
    association :keyboard
  end
end
