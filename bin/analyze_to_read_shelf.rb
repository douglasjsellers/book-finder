require_relative '../lib/book-finder.rb'
require 'dotenv/load'
require 'goodreads'
@chrome = Chrome.new

def fetch_asin( asin )
  puts asin
  amazon = Amazon.new( @chrome )
  book = amazon.find_book_by_asin( asin )
  
  puts "#{book.title},#{book.on_kindle_unlimited?},#{book.kindle_price}"
end

client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])

shelf = client.shelf(ENV['GOODREADS_USER_ID'], 'to-read')
shelf.books.each do |book|
  fetch_asin( book.to_h['book']['isbn'] ) if book.to_h['book']['isbn']
end
