require 'dotenv/load'
require 'goodreads'
puts ENV['GOODREADS_API_KEY']
client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])
page = 1
more_pages = true
while more_pages do
  shelf = client.shelf(36167974, 'to-read', {page:page})
  books = shelf.books
  books.each do |book|
    puts "#{book['book']['isbn13']} / #{book['book']['title']}"
  end
  more_pages = (shelf.end != shelf.total)
  page += 1
end
