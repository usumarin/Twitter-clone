FactoryBot.define do
  factory :firstuser, class: User do
    email {'factory@example.com'}
    password {'password'}
    name {'factory'}
  end
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password'}
    sequence(:profile) { |n| "person#{n}" }
  end
end