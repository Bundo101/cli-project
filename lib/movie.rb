
class Movie
  
  attr_accessor :title, :year, :rank, :url, :critic_score, :user_score, :sample_review
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  # def find_movie_by_rank(rank)
  #   self.all.detect { |movie| movie.rank == rank }    
  # end
  
  def self.create_movies(array_of_hashes)
    array_of_hashes.each do |hash|
      #binding.pry
      new_movie = Movie.new
      hash.each do |attribute, data|  
        new_movie.send("#{attribute}=", data)
      end
    end
  puts self.all
  end
  
  def get_extra_info
   movie_hash = Scraper.new.scraped_movie_to_hash(self)
   

  end
  
end