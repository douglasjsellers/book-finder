class Chrome
  def initialize
    @options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @driver = Selenium::WebDriver.for(:chrome, options: @options)
  end

  def fetch_url( url )
    @driver.get(url)
    @driver
  end
  
  
end
