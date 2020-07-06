# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do |n|
  user = User.create!(name: Faker::Name.name,
              email: Faker::Internet.email,
              password: 'password',
              profile: Faker::Lorem.sentence,
  )
  tweet = Tweet.create!(
    content: Faker::Lorem.sentence,
    user_id: Faker::Number.between(from: 1, to: 30)
  )
end