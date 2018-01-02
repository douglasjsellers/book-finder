require_relative '../lib/book-finder.rb'
require 'dotenv/load'
require 'goodreads'

@chrome_overdrive = Chrome.new
@chrome = Chrome.new
if( ARGV.length == 0 )
  puts "usage ruby analyze_a_to_read_shelf_for_overdrive.rb USER_GOODREADS_ID OVERDRIVE_URL(s)"
  puts "example ruby analyze_a_to_read_shelf_for_overdrive.rb 36167974 https://hawaii.overdrive.com https://lapl.overdrive.com"
else
  @goodreads_user_id = ARGV.first  
  @libraries = ARGV[1..ARGV.length]

  def fetch_library_data( title, author )
    results = @libraries.collect do |library|
      OverDrive.new( library, @chrome_overdrive ).find_book( title, author )
    end
    results = results.compact
    if( results.length > 0 )
      results = results.sort_by { |a| [-a.number_available, a.number_waiting] }
      results.first
    elsif( @libraries.length > 0 )
      "\"#{title}\",\"#{author}\", Not at any library"
    end
  end

  if( @libraries.length > 0 )
    puts "Library Book Title, Library Book Author, Library URL, Books Available to Take Out, Number of People Waiting To Take Book Out"
  else
    puts "No Libraires Specified"
  end

  client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])

  shelf = client.shelf(@goodreads_user_id, 'to-read')
  (shelf.start .. shelf.end).each do |page|
    client.shelf(@goodreads_user_id, 'to-read', {page: page} ).books.each do |book|
      puts fetch_library_data(  book.to_h['book']['title'], book.to_h['book']['authors']['author']['name'] )
    end
  end
end
