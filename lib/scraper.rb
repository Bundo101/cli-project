require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  end
  
  def get_movies
    self.scrape_list_page.css("div.slide")
  end
  
  def make_movies
    self.get_movies
  end
  
  
end




#position_title_releaseyear = page.css("div.slide").first.css("h2.slide-title-text").text