require 'open-uri'
require 'json'
require 'pry'

URL = "https://www.googleapis.com/books/v1/volumes?q=subject:fiction&maxResults=40"

response = open(URL).read
books = JSON.parse(response)

books['items'].each do |item|
  book = Book.new
  book.title = item["volumeInfo"]["title"]
  book.snippet = item["volumeInfo"]["description"]
  author = item['volumeInfo']['authors'].first
  first_name = author.split(" ").first
  last_name = author.split(" ").last

  book.author = Author.find_or_create_by(
  first_name: first_name,
  last_name: last_name
  )

  book.save
end
