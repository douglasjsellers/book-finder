require_relative '../lib/book-finder.rb'
require 'dotenv/load'
require 'goodreads'

@chrome_overdrive = Chrome.new
@chrome = Chrome.new
@libraries = ['https://hawaii.overdrive.com','https://lapl.overdrive.com']

def fetch_library_data( title, author )
  results = @libraries.collect do |library|
    OverDrive.new( library, @chrome_overdrive ).find_book( title, author )
  end
  results = results.compact
  if( results.length > 0 )
    results.join( "," )
  else
    "#{title},#{author}, Not at any library"
  end
end

def fetch_asin( asin, title, author )
  begin
    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( asin )
    if( book )
      puts "\"#{asin}\",\"#{title}\",#{book.on_kindle_unlimited?},#{book.kindle_price},#{fetch_library_data( title, author)}"
    else
      puts "\"#{asin}\",\"#{title}\",false,-1,#{fetch_library_data( title, author)}"
    end
  rescue Exception => e
    @chrome_overdrive = Chrome.new
    @chrome = Chrome.new
    
    if( e.message == "Net::ReadTimeout" )
      fetch_asin( asin, title, author )
    else
      puts "Bad ASIN: #{asin}: #{e.message}"
    end
  end
end

def find_isbn( book, client )
  to_return = nil
  if book.to_h['book']['isbn']
    to_return = book.to_h['book']['isbn']
  else
    #sometimes, for some strange reason, the isbn isn't included with a book that is returned via a self
    book_with_details = client.book( book['book']['id'] )
    if( book_with_details['asin'] && book_with_details['asin'].length > 0 )
      to_return = book_with_details['asin']
    elsif( book_with_details['isbn'] && book_with_details['isbn'].length > 0 )
      to_return = book_with_details['isbn']
    elsif( book_with_details['isbn13'] && book_with_details['isbn13'].length > 0 )
      to_return = book_with_details['isbn13']
    end
  end
  
  to_return
end

client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])

shelf = client.shelf(ENV['GOODREADS_USER_ID'], 'to-read')
(shelf.start .. shelf.end).each do |page|
  client.shelf(ENV['GOODREADS_USER_ID'], 'to-read', {page: page} ).books.each do |book|
    fetch_asin( find_isbn( book, client ), book.to_h['book']['title'], book.to_h['book']['authors']['author']['name'] )
  end
end
