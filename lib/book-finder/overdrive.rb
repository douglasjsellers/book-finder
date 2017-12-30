class OverDrive
  def initialize( overdrive_url, chrome = Chrome.new )
    @overdrive_url = overdrive_url
    @chrome = chrome
    @debug = false
  end


  def find_book( title, author )
    driver = @chrome.fetch_url(@overdrive_url)
    navigate_to_advanced_search( driver )
    perform_advance_search( driver, title, author )
    if( any_results_returned?( driver ) )
      fetch_book_info( driver, title, author )
    else
      return nil
    end
  end

  private
  def any_results_returned?( driver )
    title = driver.find_element(:xpath => "//span[contains(@class, 'search-text')]")
    puts title.text if @debug
    driver.find_elements( :xpath => "//ul[contains(@class, 'js-title-collection-view')]/li" ).count > 0
  end

  def fetch_book_info( driver, title, author )
    driver.find_elements( :xpath => "//ul[contains(@class, 'js-title-collection-view')]/li" ).first.click
    availabilty = driver.find_element(:xpath => "//span[contains(@class, 'availabilityText')]").text
    waiting = driver.find_element(:xpath => "//span[contains(@class, 'waitingText')]").text
    OverDriveBook.new( title, author, driver.current_url, availabilty, waiting )
  end
  
  def navigate_to_advanced_search( driver )
    search_node = driver.find_element(:xpath => "//*[contains(@class, 'js-toggleSearch')]")
    search_node.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 5)
    advanced_search_node = wait.until {
      element = driver.find_element(:xpath => "//a[contains(@class, 'advanced-search-desktop')]")
      element if element.displayed?
    }
    advanced_search_node.click
    
  end

  def perform_advance_search( driver, title, author )
    driver.find_element(:id, 'q').send_keys title
    driver.find_element(:id, 'creator').send_keys author
    formats = select=Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "format"))
    formats.select_by(:value, "ebook")
    search_button = driver.find_element(:xpath => "//button[contains(@class, 'AdvancedSearch-submit')]")
    search_button.click
  end
  
end
