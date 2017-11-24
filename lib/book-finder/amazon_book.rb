class AmazonBook
  attr_accessor :title, :kindle_unlimited, :kindle_price
  def initialize( title, kindle_unlimited, kindle_price )
    @title = title
    @kindle_unlimited = kindle_unlimited
    @kindle_price = kindle_price
  end

  def on_kindle_unlimited?
    @kindle_unlimited
  end
  
end
