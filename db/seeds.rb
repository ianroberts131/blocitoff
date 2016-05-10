require 'faker'

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
    )
end

users = User.all

50.times do
  Item.create!(
    user: users.sample,
    name: Faker::Hipster.sentence(rand(2..5))
    )
end

User.create!(
  email: "ianroberts131@gmail.com",
  password: "password",
  password_confirmation: "password"
  )


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Item.count} items created"