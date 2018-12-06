# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 10.times do
#   User.create(username: Faker::Name.name, email: Faker::Internet.email)
# end
20.times do
  User.create(username: Faker::Name.name, password: "123456", dogs: true, age: rand(18..50) , sex: Faker::Gender.binary_type, location: "NYC", bio:Faker::Lorem.paragraph , img_url:'https://www.thehumanenterprise.com.au/wp-content/uploads/2017/06/Empty-Profile-Testimonials.jpg')
end
