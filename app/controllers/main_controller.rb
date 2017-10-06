class MainController < ApplicationController
  def index
    # page = ParsingPage.new('https://test2-alkp.c9users.io/test')
    page = ParsingPage.new('https://yandex.ru/search/?text=rails')
    # page = ParsingPage.new('http://www.google.ru/search?q=rails')
    page.request
    links = page.yandex_search_links
    create_list_links(links)
  end
  
  def test
  end
  
  private
  
  def create_list_links(links)
    @threads = []
    @results = {}
    links.each do |url|
      new_request{ url }
    end
  
    @threads.each { |thr| thr.join }
  
    @results = @results.sort_by{|k, v| v}
  end
  
  def new_request
    @threads << Thread.new do
      url = Addressable::URI.parse( yield ).host
      u = ParsingPage.new("https://www.alexa.com/siteinfo/#{url}")
      u.request
      rank = u.html.xpath("//*[@class='metrics-data align-vmiddle']").first.text.gsub(",", "")
      @results[yield] = rank.to_i
    end
  end
end
