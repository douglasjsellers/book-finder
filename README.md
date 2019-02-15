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

### Kindle Information + Library Information
The most common usage of this tool is to analyze your to-read shelf for all information:

`bundle exec ruby bin/analyze_a_to_read_shelf.rb <GOODREADS USER ID> <OVERDRIVE LIBRARY URLS>`

The GoodReads user id can be found in the url of your to-read self.  For example:

`https://www.goodreads.com/review/list/36167974?shelf=to-read`

My GoodReads user id is 36167974.

The overdrive library urls can be found by going to the overdrive library search (https://www.overdrive.com/libraries), putting in your zip, clicking on your library and then clicking on the name of the library system that appears in the popup on the map.  For example, my zip code is 91411, my library is the "Sherman Oaks - Martin Pollard Library" and my library system is "Los Angeles Public Library".  Clicking this last link took me to "https://lapl.overdrive.com/" which is the overdrive url of my library.  So to analyze my shelf I would run:

`bundle exec ruby bin/analyze_a_to_read_shelf.rb 36167974 https://lapl.overdrive.com/`

If you happen to have multiple library cards you can run the same command with multiple library urls.  For example:

`bundle exec ruby bin/analyze_a_to_read_shelf.rb 36167974 https://hawaii.overdrive.com https://lapl.overdrive.com https://sfpl.overdrive.com/ https://freelibrary.overdrive.com/ https://afpls.overdrive.com/`

Will run an analysis on your to-read shelf but look at two different overdrive libraries to see what the availability looks like.

### Just Library Information
The slowest part of this whole process is determing the kindle price and the kindle unlimited availability.  I have found that, mostly, knowing the kindle price is unnecessary.  Mostly you are focused on finding books on overdrive.  If that is all you want it is actually faster to use 
`bundle exec ruby bin/analyze_a_to_read_shelf_for_overdrive.rb <GOODREADS USER ID> <OVERDRIVE LIBRARY URLS>`

This will just scan the libraries and output the library information.


## A Note on Multiple Library Cards
If your goal is to spend as little as possible on reading every year, and you read a decent number of books, the best bang for your buck is probably not in a Kindle Unlimited Subscription or in just buying books that your local library doesn't have but rather in a non-resident library card at one of the big libraries.  The way that most, larger, public libraries work is that if you are a resident of the county that the library exists in you get a library card for free.  If you don't live in that county you can often pay a yearly fee to get a library card.  The larger libraries often have fantastic selection and can, when combined with your local library card, knock your yearly book buying bill to next to nothing.  Here is a small list of larger libraries that have non-resident programs:
* Los Angeles : https://www.lapl.org/about-lapl/borrower-services#apply
* Fairfax County: https://m.fairfaxcounty.gov/library/accountservices/nonresapp.htm
* Free Library of Philadelphia: https://know.freelibrary.org/MyResearch/register
* Houston Public Library: http://houstonlibrary.org/find-it/my-link
* Atlanta-Fulton Public Library: http://www.afpls.org/afplsservices/library-cards
* Charlotte Mecklenburg Library: https://www.cmlibrary.org/getacard
* Brooklyn Public Library: https://www.bklynlibrary.org/use-the-library/borrow
* Austin Public Library: http://library.austintexas.gov/mylibrarycard

You can determine what kind of coverage this would give you by running an analyze with all of the overdrive URLs for these libraries:

`bundle exec ruby bin/analyze_a_to_read_shelf_for_overdrive.rb <GOODREADS USER ID>  https://austinlibrary.overdrive.com/ https://brooklyn.overdrive.com/ https://plcmc.overdrive.com/ https://afpls.overdrive.com/ https://hadc.overdrive.com/ https://freelibrary.overdrive.com/ https://lapl.overdrive.com/ https://fairfax.overdrive.com/`

This list is really just the tip of the iceberg - there are tons more libraries out there that support non-resident cards.  Adding one more large library to your overdrive account can greatly decrease your yearly spend on books.
