class OverDrive
  def initialize( overdrive_url, chrome = Chrome.new )
    @overdrive_url = overdrive_url
    @chrome = chrome
    @debug = false
  end


  def find_book( title, author )
    driver = @chrome.fetch_url(@overdrive_url)
    title = title.split( ':' ).first.strip
    title = title.split( '(' ).first.strip
    author = author.strip
    puts "searching for #{title}, #{author} for #{@overdrive_url}" if @debug    
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
    driver.find_elements( :xpath => "//ul[contains(@class, 'js-title-collection-view')]/li" ).count > 0
  end

  def fetch_book_info( driver, title, author )
    driver.find_elements( :xpath => "//ul[contains(@class, 'js-title-collection-view')]/li" ).first.click
    availabilty = driver.find_element(:xpath => "//span[contains(@class, 'availabilityText')]").text
    waitingElements = driver.find_elements(:xpath => "//span[contains(@class, 'waitingText')]")
    waiting = "0"
    if( waitingElements.length > 0 )
      waiting = waitingElements.first.text
    end
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
