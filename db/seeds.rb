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
Review.destroy_all
puts "DB is clean"

shyama = User.new(first_name: "Shyama",
                  last_name: "Menon",
                  address: Faker::Address.street_address,
                  email: "shyama@booksgalore.com",
                  password: '123456')
shyama.photo.attach(io: File.open("./app/assets/images/shyama.jfif"), filename: "shyama_image.png", content_type: "image/png")
shyama.save

ana = User.new(first_name: "Ana",
               last_name: "Mikic",
               address: Faker::Address.street_address,
               email: "ana@booksgalore.com",
               password: '123456')
ana.photo.attach(io: File.open("./app/assets/images/ana.png"), filename: "ana_image.png", content_type: "image/png")
ana.save

verity = User.new(first_name: "Verity",
                  last_name: "Shuker",
                  address: Faker::Address.street_address,
                  email: "verity@booksgalore.com",
                  password: '123456')
verity.photo.attach(io: File.open("./app/assets/images/verity.jfif"), filename: "verity_image.png", content_type: "image/png")
verity.save

seb = User.new(first_name: "Seb",
               last_name: "Rojas",
               address: Faker::Address.street_address,
               email: "seb@booksgalore.com",
               password: '123456')
seb.photo.attach(io: File.open("./app/assets/images/seb.jfif"), filename: "seb_image.png", content_type: "image/png")
seb.save

puts "Created #{User.count} users"

# Scrape books from book depository

url = "https://www.bookdepository.com/bestsellers"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)
html_doc.search(".book-item").first(35).each do |book|
  begin
    book_url = "https://www.bookdepository.com/#{book.search(".item-img a").attribute("href")}"
    html_file_book = URI.open(book_url).read
  rescue => e
    puts e
    next
  end
  html_doc_book = Nokogiri::HTML(html_file_book)
  begin
    book = Book.new(title: html_doc_book.search("h1").text.strip,
                    author: html_doc_book.search(".author-info a").text.strip,
                    genre: Faker::Book.genre,
                    price: (rand(1..10)).fdiv(4),
                    user_id: rand(User.first.id..User.last.id),
                    summary: html_doc_book.search(".item-excerpt").text.strip.delete_suffix!("show more").strip[0, 1000])
  rescue => e
    puts e
    next
  end
  begin
    photo_file = URI.open(html_doc_book.search(".item-img-content img").attribute("src"))
  rescue => e
    puts e
    next
  end
  book.photo.attach(io: photo_file, filename: "book#{book.id}_image.png", content_type: "image/png")
  book.save
  reviews_count = rand(0..3)
  reviews_count.times do
    review = Review.new(content: Faker::Lorem.paragraph(sentence_count: 1),
                        rating: rand(1..5),
                        book: book,
                        user_id: rand(User.first.id..User.last.id))
    review.save
    puts "Review with id #{review.id} created"
  end
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
