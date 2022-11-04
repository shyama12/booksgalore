# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Start"
Book.destroy_all
Booking.destroy_all
User.destroy_all
puts "DB is clean"

User.create(first_name: "Shyama",
            last_name: "Menon",
            address: Faker::Address.street_address,
            email: "shyama@booksgalore.com",
            password: '123456')

User.create(first_name: "Ana",
            last_name: "Mikic",
            address: Faker::Address.street_address,
            email: "ana@booksgalore.com",
            password: '123456')

User.create(first_name: "Verity",
            last_name: "Shuker",
            address: Faker::Address.street_address,
            email: "verity@booksgalore.com",
            password: '123456')

User.create(first_name: "Seb",
            last_name: "Rojas",
            address: Faker::Address.street_address,
            email: "seb@booksgalore.com",
            password: '123456')

puts "Created #{User.count} users"

20.times do
  Book.create(title: Faker::Book.title,
              author: Faker::Book.author,
              genre: Faker::Book.genre,
              price: rand(1..3),
              summary: Faker::TvShows::GameOfThrones.quote,
              user_id: rand(User.first.id..User.last.id))
  puts "created #{Book.count} books"
end
puts "End"
