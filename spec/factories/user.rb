FactoryBot.define do
  factory :user do
    name { 'name' }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
