FactoryBot.define do
  factory :comment do
    association :user
    association :keyboard

    sequence(:body) { |n| "Comment Body #{n}" }
  end
end
