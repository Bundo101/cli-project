require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
    #binding.pry
    #puts doc
  end
  
  def get_movies
    example = self.scrape_list_page.css("div.slide")
    # basic_movie_data = example.css("h2.slide-title-text").text
    # rank, title, year = str.split(" ")
    # puts basic_movie_data
    #binding.pry
  end
  
  def make_movies
    self.get_movies.each do |movie|
      new_movie = Movie.new
      basic_movie_data = movie.css("h2.slide-title-text").text
      rank, title, year = basic_movie_data.split(" ")
      binding.pry
      new_movie.rank = rank
      new_movie.title = title
      new_movie.year = year
      puts new_movie
    end
  end
  
  # def print_movies
  #   self.make_movies
  #   Movie.all.each do |movie|
  #     if movie.title
  #       puts "#{movie.rank} #{movie.title} #{movie.year}"
  #     end
  #   end
  # end
  
end

#rank_title_year = page.css("div.slide").first.css("h2.slide-title-text").text