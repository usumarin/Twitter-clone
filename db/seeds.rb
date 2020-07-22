# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'first',
            email: 'first@example.com',
            password: 'password',
            profile: 'first')
user = User.find(1)
user.avatar.attach(io: File.open('app/assets/images/first.jpg'),filename: 'user-image.jpg')
User.create(name: 'ゲストユーザー',
            email: 'guest@example.com',
            password: 'password',
            profile: 'ゲストユーザーです')
user = User.find_by(email: 'guest@example.com')
user.avatar.attach(io: File.open('app/assets/images/test-user.jpg'),filename: 'user-image.jpg')
50.times do |n|
  user = User.create!(name: Faker::Name.name,
              email: Faker::Internet.email,
              password: 'password',
              profile: Faker::Lorem.sentence,
  )
end
50.times do |n|
  tweet = Tweet.create!(
    content: Faker::Lorem.sentence,
    user_id: Faker::Number.between(from: 1, to: 30)
  )
end