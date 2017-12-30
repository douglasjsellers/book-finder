class OverDriveBook
  attr_accessor :title, :author, :url, :number_available, :number_waiting
  def initialize( title, author, url, availabilty_text, waiting_text )
    @title = title
    @author = author
    @url = url
    @number_available = parse_availability_text( availabilty_text )
    @number_waiting = parse_waiting_text( waiting_text )
  end

  def to_s
    return "\"#{@title}\",\"#{@author}\",\"#{@url}\",#{@number_available},#{@number_waiting}"
  end
  

  private
  def parse_availability_text( text )
    split_text = text.strip.split( ' ' )
    split_text[0].to_i
  end


  def parse_waiting_text( text )
    text.strip.split( ' ' ).first.to_i
  end
  
end
