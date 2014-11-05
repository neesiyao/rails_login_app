# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Si Yao",
             email: "neesiyao1@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)
User.create!(name: "Jiew Meng",
             email: "jiewmeng1@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             examiner: true)
User.create!(name: "Nicholas Teo",
             email: "nicholasteo@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar")
10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
