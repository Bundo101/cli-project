
class Movie
  
  attr_accessor :title, :year, :rank, :url, :critic_score, :user_score, :sample_review, :plot_summary
  
  @@all = []
  
  def initialize
    @@all << self             #create separate save method
  end
  
  def self.all
    @@all
  end
  
  def self.prepare_movies
    array_of_hashes = Scraper.new.scraped_list_to_array_of_hashes
    array_of_hashes.each do |hash|
      #binding.pry
      new_movie = self.create(args)                                   #use #create or #initialize to populate attributes
      hash.each do |attribute, data|  
        new_movie.send("#{attribute}=", data)
      end
    end
  end
  
  def get_extra_info
    unless self.critic_score  
      movie_hash = Scraper.new.scraped_movie_to_hash(self)
      movie_hash.each do |attribute, data|  
        self.send("#{attribute}=", data)
      end
    end
  end
  
end