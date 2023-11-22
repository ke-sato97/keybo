FactoryBot.define do
  factory :keyboard_tag do
    association :keyboard
    association :tag
  end
end
