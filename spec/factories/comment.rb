FactoryBot.define do
  factory :comment do
    user
    keyboard

    sequence(:body) { |n| "Comment Body #{n}" }
  end
end
