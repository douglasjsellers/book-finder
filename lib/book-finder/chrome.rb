class Chrome
  def initialize
    @user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36"
    @options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @driver = Selenium::WebDriver.for(:chrome, options: @options, switches: %W[--user-agent=#{@user_agent} --window-size=1280,1696])
  end
  def fetch_url( url )
    @driver.get(url)
    @driver
  end
end
