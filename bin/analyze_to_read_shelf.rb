require_relative '../lib/book-finder.rb'
require 'dotenv/load'
require 'goodreads'

client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])

shelf = client.shelf(ENV['GOODREADS_USER_ID'], 'to-read')
shelf.books.each do |book|
  puts book.to_h['book']['isbn']
  puts ""
end
#puts client.book_by_title("Waiter to the Rich and Shameless: Confessions of a Five-Star Beverly Hills Server").to_json
 
#shelf = GoodReadsShelf.new( "to-read" )

def fetch_asin( asin )
chrome = Chrome.new
amazon = Amazon.new( chrome )
book = amazon.find_book_by_asin( asin )
 
puts "#{book.title},#{book.on_kindle_unlimited?},#{book.kindle_price}"
  
end

#fetch_asin "B00QXA0TX4"
#fetch_asin"B00ADPR5WI"

