
class Movie
  
  attr_accessor :title, :year, :rank, :url, :critic_score, :user_score, :sample_review
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.prepare_movies
    array_of_hashes = Scraper.new.scraped_list_to_array_of_hashes
    array_of_hashes.each do |hash|
      #binding.pry
      new_movie = self.new
      hash.each do |attribute, data|  
        new_movie.send("#{attribute}=", data)
      end
    end
  end
  
  def get_extra_info
    movie_hash = Scraper.new.scraped_movie_to_hash(self)
    movie_hash.each do |attribute, data|  
      self.send("#{attribute}=", data)
    end
  end
  
end