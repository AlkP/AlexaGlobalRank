class ParsingPage  
  require "open-uri"
#   require 'net/http'
#   require 'json'
  
  def initialize(url)
    @url = url
  end
  
  def request
    doc = Nokogiri::HTML(open(@url).read)
    @html = doc
  end
  
  def yandex_search_links
    result = []
    @html.xpath("//*[@class='link link_theme_normal organic__url link_cropped_no i-bem']").each do |e|
      result << e['href']
    end
    return result
  end
  
  def html
    @html
  end
end
