require 'selenium-webdriver'
 
class Amazon
  def initialize( chrome = null )
    if( chrome )
      @chrome = chrome
    else
      @chrome = Chrome.new
    end
      
  end
 
  def find_book_by_asin( book_asin )
    driver = @chrome.fetch_url("https://www.amazon.com/dp/#{book_asin}")
    title = driver.find_element( :id, "ebooksProductTitle" ).text
    
    price_node =driver.find_element(:xpath => "//tr[contains(@class, 'kindle-price')]/td[contains(@class, 'a-color-price')]")
    price = price_node.text.gsub( price_node.find_elements( :xpath => "*" ).first.text, "" )

    kindle_unlimited = driver.find_elements(:xpath => "//i[contains( @class, 'a-icon-kindle-unlimited')]").count > 0
    return AmazonBook.new( title, kindle_unlimited, price )
  end
   
end
