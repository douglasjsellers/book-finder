require 'dotenv/load'
require 'goodreads'

client = Goodreads::Client.new(api_key: ENV['GOODREADS_API_KEY'], api_secret: ENV['GOODREADS_SECRET_KEY'])
puts client.book_by_title("Waiter to the Rich and Shameless: Confessions of a Five-Star Beverly Hills Server").to_json
