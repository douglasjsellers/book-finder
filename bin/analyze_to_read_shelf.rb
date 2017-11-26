require_relative '../lib/book-finder.rb'
 
#shelf = GoodReadsShelf.new( "to-read" )
 
asin = "B00QXA0TX4"
chrome = Chrome.new
amazon = Amazon.new( chrome )
book = amazon.find_book_by_asin( asin )
 
puts "#{book.title},#{book.on_kindle_unlimited?},#{book.kindle_price}"

asin ="B00ADPR5WI"

amazon = Amazon.new( chrome )
book = amazon.find_book_by_asin( asin )
 
puts "#{book.title},#{book.on_kindle_unlimited?},#{book.kindle_price}"
