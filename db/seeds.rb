require 'open-uri'
require 'nokogiri'
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

# Scrape books from book depository

url = "https://www.bookdepository.com/bestsellers"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)
html_doc.search(".book-item").first(20).each do |book|
  begin
    book_url = "https://www.bookdepository.com/#{book.search(".item-img a").attribute("href")}"
    html_file_book = URI.open(book_url).read
  rescue => e
    next
  end
  html_doc_book = Nokogiri::HTML(html_file_book)
  book = Book.new(title: html_doc_book.search("h1").text.strip,
                  author: html_doc_book.search(".author-info a").text.strip,
                  genre: Faker::Book.genre,
                  price: rand(100..300) / 100,
                  user_id: rand(User.first.id..User.last.id),
                  summary: html_doc_book.search(".item-excerpt").text.strip.delete_suffix!("show more").strip)
  photo_file = URI.open(html_doc_book.search(".item-img-content img").attribute("src"))
  book.photo.attach(io: photo_file, filename: "book#{book.id}_image.jpg", content_type: "image/jpg")
  book.save
  puts "Created book with id #{book.id}"
end

# to books populate without scraping
# 20.times do
#   Book.create(title: Faker::Book.title,
#               author: Faker::Book.author,
#               genre: Faker::Book.genre,
#               price: rand(1..3),
#               summary: Faker::TvShows::GameOfThrones.quote,
#               user_id: rand(User.first.id..User.last.id))
#   puts "created #{Book.count} books"
# end
# puts "End"
