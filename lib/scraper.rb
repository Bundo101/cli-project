require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  end
  
  def get_movies
    self.scrape_list_page.css("div.slide")
  end
  
  def make_movies
    self.get_movies.each do |movie|
      new_movie = Movie.new
      basic_movie_data = movie.css("h2.slide-title-text").text
      rank, title, year = str.split(" ")
      new_movie.rank = rank
      new_movie.title = title
      new_movie.year = year
    end
  end
  
  
end

#rank_title_year = page.css("div.slide").first.css("h2.slide-title-text").text