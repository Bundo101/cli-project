require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  end
  
  def get_movies
    example = self.scrape_list_page.css("div.slide")
  end
  
  def make_movies
    self.get_movies.each do |movie|
      new_movie = Movie.new
      
      basic_movie_data = movie.css("h2.slide-title-text").text
      rank, title, year = basic_movie_data.split("\"").map(&:strip)
      new_movie.rank, new_movie.title, new_movie.year = rank, title, year
      
      url = movie.css("div p a").attribute("href").value
      new_movie.url = url
      
      critic_score_array = movie.css("div p").text.split(" ")
      critic_score = critic_score_array.find { |element| element.include?("/") }.split("score:").last
      new_movie.critic_score = critic_score
    end
  end
  
  def print_movies
    self.make_movies
    Movie.all.each do |movie|
      if movie.title
        puts "#{movie.rank} #{movie.title} #{movie.year} #{movie.url} #{movie.critic_score}"
      end
      #puts movie.url unless movie.url.include?("metacritic.com") && movie.url.length < 100
        
    end
  end
  
end

#url = page.css("div.slide").css("div p a").attribute("href").value