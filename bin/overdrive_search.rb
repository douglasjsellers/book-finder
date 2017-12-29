require_relative '../lib/book-finder.rb'
require 'dotenv/load'

@chrome = Chrome.new

overdrive = OverDrive.new( 'https://hawaii.overdrive.com', @chrome )

overdrive_book = overdrive.find_book( "The Library at Mount Char", "Scott Hawkins" )

