require_relative '../lib/book-finder.rb'
 
#shelf = GoodReadsShelf.new( "to-read" )
 
asin = "B00QXA0TX4"
amazon = Amazon.new
book = amazon.find_book_by_asin( asin )
 
puts "#{book.title},#{book.on_kindle_unlimited?},#{book.kindle_price}"

asin ="B00ADPR5WI"

amazon = Amazon.new
book = amazon.find_book_by_asin( asin )
 
puts "#{book.title},#{book.on_kindle_unlimited?},#{book.kindle_price}"
