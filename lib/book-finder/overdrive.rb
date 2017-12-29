class OverDrive
  def initialize( overdrive_url, chrome = Chrome.new )
    @overdrive_url = overdrive_url
    @chrome = chrome
  end


  def find_book( title, author )
    driver = @chrome.fetch_url(@overdrive_url)
    search_node = driver.find_element(:xpath => "//*[contains(@class, 'js-toggleSearch')]")
    search_node.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 5)
    advanced_search_node = wait.until {
      element = driver.find_element(:xpath => "//a[contains(@class, 'advanced-search-desktop')]")
      element if element.displayed?
    }
    advanced_search_node.click
    
    puts driver.title
  end
  
end
