class AmazonBook
  attr_accessor :title, :kindle_unlimited, :kindle_price, :author
  def initialize( title, author,kindle_unlimited, kindle_price )
    @title = title
    @author = author
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
