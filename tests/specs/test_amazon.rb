require_relative '../spec_helper'

describe Amazon do

  before :all do
    @chrome = Chrome.new
    @kindle_asin = "B00ADPR5WI"
    @kindle_unlimited_asin = "B00QXA0TX4"
    @kindle_bad_asin ="0071401946"
  end

  it "should be able to get the correct title of a kindle book" do
    @chrome.nil?.should == false

    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( @kindle_unlimited_asin )
    book.title.should == "Waiter to the Rich and Shameless: Confessions of a Five-Star Beverly Hills Server"

    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( @kindle_asin )
    book.title.should == "Iron Man: My Journey through Heaven and Hell with Black Sabbath"
  end
  
  it "should be able to get a price from a kindle page on amazon" do
    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( @kindle_asin )
    book.kindle_price.should == 11.99
  end

  it "should be able to get a price from a kindle unlimitedpage on amzaon" do
    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( @kindle_unlimited_asin )
    book.kindle_price.should == 0.99
  end
  
  it "should be able to determine if a kindle book is not in kindle unlimited" do
    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( @kindle_asin )
    book.on_kindle_unlimited?.should == false
  end

  it "should be able to determine if a kindle book is on kindle unlimtited" do
    amazon = Amazon.new( @chrome )
    book = amazon.find_kindle_book_by_asin( @kindle_unlimited_asin )
    book.on_kindle_unlimited?.should == true
  end

  it "should be able to get a kindle price when sent to a hardcover amazon page" do
    hardcover_asn = "0306819554"
    amazon = Amazon.new( @chrome )    
    book = amazon.find_kindle_book_by_asin( hardcover_asn )
    book.kindle_price.should == 11.99
  end

  it "should be able to find price on an undiscounted kindle book" do
    hardcover_asn = "0575088273"
    amazon = Amazon.new( @chrome )    
    book = amazon.find_kindle_book_by_asin( hardcover_asn )
    book.kindle_price.should == 8.99
    
  end

  it "should be able to find no kindle book if one doesn't exist" do
    hardcover_asn = "0445203005"
    amazon = Amazon.new( @chrome )    
    amazon.find_kindle_book_by_asin( hardcover_asn ).should == nil
  end

  it "should return nil " do
    amazon = Amazon.new( @chrome )    
    amazon.find_kindle_book_by_asin( @kindle_bad_asin ).should == nil
  end

end

