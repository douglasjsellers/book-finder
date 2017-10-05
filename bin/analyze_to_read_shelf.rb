require_relative '../lib/book-finder.rb'

#shelf = GoodReadsShelf.new( "to-read" )

amazon = Amazon.new
amazon.find_book( 'neuromancer' )
