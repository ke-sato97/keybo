FactoryBot.define do
  factory :contact do
    name { 'name' }
    email { Faker::Internet.unique.email }
    subject { 'subject' }
    message { 'message' }
  end
end
