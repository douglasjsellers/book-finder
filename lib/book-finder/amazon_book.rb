class AmazonBook
  attr_accessor :kindle_unlimited, :kindle_price
  def initialize( kindle_unlimited, kindle_price )
    @kindle_unlimited = kindle_unlimited
    @kindle_price = clean_up_price( kindle_price )
  end

  def on_kindle_unlimited?
    @kindle_unlimited
  end

  private
  def clean_up_price( price )
    price.strip.gsub( "$", "" ).to_f
  end
  
  
end
