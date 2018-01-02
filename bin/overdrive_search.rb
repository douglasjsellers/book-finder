require_relative '../lib/book-finder.rb'
require 'dotenv/load'

@chrome = Chrome.new

overdrive = OverDrive.new( 'https://hawaii.overdrive.com', @chrome )
require_relative '../lib/book-finder.rb'
require 'dotenv/load'
require 'goodreads'

@chrome_overdrive = Chrome.new
@chrome = Chrome.new

@goodreads_user_id = 36167974
@libraries =  ["https://hawaii.overdrive.com", "https://lapl.overdrive.com"]


def fetch_library_data( title, author )
  results = @libraries.collect do |library|
    OverDrive.new( library, @chrome_overdrive ).find_book( title, author )
  end
  results = results.compact
  if( results.length > 0 )
    results = results.sort_by { |a| [-a.number_available, a.number_waiting] }
    results.join( "," )
  elsif( @libraries.length > 0 )
    "\"#{title}\",\"#{author}\", Not at any library"
  end
end

if( @libraries.length > 0 )
  puts "Library Book Title, Library Book Author, Library URL, Books Available to Take Out, Number of People Waiting To Take Book Out"
else
  puts "No Libraires Specified"
end


puts fetch_library_data(  "The Power", "Naomi Alderman" )
