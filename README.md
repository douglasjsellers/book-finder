# Book Finder - Take your GoodReads to-read shelf and find out kindle and library availability
The goal of this program is to help people spend as little as possible on books each year.  It does that by producing a CSV that takes all of the books on your goodreads to-read shelf and finds out what the kindle price is, if it's available on kindle unlimited, if it's available on any of the overdrive library cards that you have, how many copies are available at each library and how many people are waiting in each libraries queue.  This can then be used to facilitate a next book to read decision.

## Setup
After cloning this repo you will need to put a .env file in the root directory that is formatted like so:
`
GOODREADS_API_KEY='My API Key'
GOODREADS_SECRET_KEY='MY SECRET KEY'`

You can optain a api key and secret throught the goodreads api program here: https://www.goodreads.com/api/keys.  Once you have filled in this .env file you will then have to do a 
`bundle install` 
to get the appropriate dependencies installed.

## Usage
The most common usage of this tool is to analyze your to-read shelf for all information:

`bundle exec ruby bin/analyze_a_to_read_shelf.rb <GOODREADS USER ID> <OVERDRIVE LIBRARY URLS>`

The GoodReads user id can be found in the url of your to-read self.  For example:

`https://www.goodreads.com/review/list/36167974?shelf=to-read`

My GoodReads user id is 36167974.  

The overdrive library urls can be found by going to the overdrive library search (https://www.overdrive.com/libraries), putting in your zip, clicking on your library and then clicking on the name of the library system that appears in the popup on the map.  For example, my zip code is 91411, my library is the "Sherman Oaks - Martin Pollard Library" and my library system is "Los Angeles Public Library".  Clicking this last link took me to "https://lapl.overdrive.com/" which is the overdrive url of my library.  So to analyze my shelf I would run:

`bundle exec ruby bin/analyze_a_to_read_shelf.rb 36167974 https://lapl.overdrive.com/`

If you happen to have multiple library cards you can run the same command with multiple library urls.  For example:

`bundle exec ruby bin/analyze_your_to_read_shelf.rb https://hawaii.overdrive.com https://lapl.overdrive.com`

Will run an analysis on your to-read shelf but look at two different overdrive libraries to see what the availability looks like.
