require 'selenium-webdriver'

class Amazon
  def initialize
  end

  def find_book( book_name )
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.get('https://amazon.com/')
    puts driver.title    
  end
  
end
