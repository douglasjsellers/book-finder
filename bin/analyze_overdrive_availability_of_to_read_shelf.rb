require_relative '../lib/book-finder.rb'
require 'dotenv/load'
require 'goodreads'

@chrome_overdrive = Chrome.new
@libraries = ['https://hawaii.overdrive.com','https://lapl.overdrive.com']
def fetch_library_data( title, author )
  results = @libraries.collect do |library|
    OverDrive.new( library, @chrome_overdrive ).find_book( title, author )
  end
  results = results.compact
  if( results.length > 0 )
    puts results.join( "," )
  else
    puts "#{title},#{author}, Not at any library"
  end
end

client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])

shelf = client.shelf(ENV['GOODREADS_USER_ID'], 'to-read')
(shelf.start .. shelf.end).each do |page|
  client.shelf(ENV['GOODREADS_USER_ID'], 'to-read', {page: page} ).books.each do |book|
    fetch_library_data(  book.to_h['book']['title'], book.to_h['book']['authors']['author']['name'] )
  end
end
