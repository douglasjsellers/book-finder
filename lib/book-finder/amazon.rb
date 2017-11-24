require 'selenium-webdriver'
 
class Amazon
  def initialize
  end
 
  def find_book_by_asin( book_asin )
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.get("https://www.amazon.com/dp/#{book_asin}")
    title = driver.find_element( :id, "ebooksProductTitle" ).text
    
    price_node =driver.find_element(:xpath => "//tr[contains(@class, 'kindle-price')]/td[contains(@class, 'a-color-price')]")
    price = price_node.text.gsub( price_node.find_elements( :xpath => "*" ).first.text, "" )

    kindle_unlimited = driver.find_elements(:xpath => "//i[contains( @class, 'a-icon-kindle-unlimited')]").count > 0
    return AmazonBook.new( title, kindle_unlimited, price )
  end
   
end
