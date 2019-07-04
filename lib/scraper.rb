#require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  end
  
  def scrape_movie_page(url)
    doc = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  end
  
  def scraped_list_to_array_of_hashes                            
    movie_details = self.scrape_list_page.css("div.slide")
    movie_details.map do |movie|
      movie_hash = {}
      basic_movie_data = movie.css("h2.slide-title-text").text.split("\"").map(&:strip)
      movie_hash[:rank] = basic_movie_data[0].delete(".").to_i
      movie_hash[:title] = basic_movie_data[1]
      movie_hash[:year] = basic_movie_data[2].delete("()")
      url = movie.css("div p a").attribute("href").value
      movie_hash[:url] = url
      movie_hash
    end
  end
  
  def scraped_movie_to_hash(url)
    movie_data = self.scrape_movie_page(url).css("a.metascore_anchor").text
    binding.pry
  end
  
  # def make_movies
  #   self.get_movies.each do |movie|
  #     new_movie = Movie.new
      
  #     basic_movie_data = movie.css("h2.slide-title-text").text
  #     rank, title, year = basic_movie_data.split("\"").map(&:strip)
  #     new_movie.rank, new_movie.title, new_movie.year = rank, title, year
      
  #     url = movie.css("div p a").attribute("href").value
  #     new_movie.url = url
      
  #     critic_score_array = movie.css("div p").text.split(" ")
  #     critic_score = critic_score_array.find { |element| element.include?("/") }.split("score:").last
  #     new_movie.critic_score = critic_score
      
  #     user_score_array = movie.css("div p").text.split(" ")
  #     user_score = user_score_array.detect { |element| element.end_with?("/10") } 
  #     new_movie.user_score = user_score
      
  #     sample_review = movie.css("div p").text.split("said:")[1].split("—")[0]
  #     new_movie.sample_review = sample_review
  #   end
  # end
  
  
end

#url = page.css("div.slide").css("div p a").attribute("href").value