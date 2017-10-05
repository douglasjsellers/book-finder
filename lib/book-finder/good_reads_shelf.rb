require 'goodreads'
class GoodReadsShelf

  def initialize( shelf_name )
    @shelf_name = shelf_name
    @books = []
    load_books
  end

  def to_s
    to_return = ""
    @books.each do |book|
      to_return += "#{book['book']['isbn13']} / #{book['book']['title']}\n"
    end
    to_return
  end
  
  private

  def load_books
    @books = []
    client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])
    page = 1
    more_pages = true
    while more_pages do
      shelf = client.shelf(ENV['GOODREADS_USER_ID'], @shelf_name, {page:page})
      @books += shelf.books
      more_pages = (shelf.end != shelf.total)
      page += 1
    end
    @books
  end
  
  
end
