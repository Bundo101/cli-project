require_relative './movie.rb'

class Scraper
  doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  
  
end




#position_title_releaseyear = page.css("div.slide").first.css("h2.slide-title-text").text