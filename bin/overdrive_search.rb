require_relative '../lib/book-finder.rb'
require 'dotenv/load'

@chrome = Chrome.new

overdrive = OverDrive.new( 'https://hawaii.overdrive.com', @chrome )

#overdrive_book = overdrive.find_book( "The Library at Mount Char", "Scott Hawkins" )
#overdrive_book = overdrive.find_book( "Noumenon,", "Marina J. Lostetter" )
overdrive_book = overdrive.find_book( "Mastery,", "Robert Greene" )
puts overdrive_book
