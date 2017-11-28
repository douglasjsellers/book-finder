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

    driver = ensure_on_kindle_page( driver )
    wait = Selenium::WebDriver::Wait.new(:timeout => 5)    
    title_element = wait.until { driver.find_element( :id, "ebooksProductTitle" ) }
    title = title_element.text
    
    price_node = driver.find_element(:xpath => "//tr[contains(@class, 'kindle-price')]/td[contains(@class, 'a-color-price')]")
    price = price_node.text.gsub( price_node.find_elements( :xpath => "*" ).first.text, "" )

    kindle_unlimited = driver.find_elements(:xpath => "//i[contains( @class, 'a-icon-kindle-unlimited')]").count > 0
    return AmazonBook.new( title, kindle_unlimited, price )
  end

  private
  def ensure_on_kindle_page( driver )
    driver.find_elements(:xpath => "//div[contains( @id, 'formats')]//*/ul/li//*/a").each do |element|
      if (element.text.index( 'Kindle' ) )
        element.click
        break
      end
    end

    driver
  end
  
end
