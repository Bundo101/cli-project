
class Movie
  
  attr_accessor :title, :year, :rank, :url, :sample_review, :critic_score, :user_score, :plot_summary
  
  @@all = []
  
  def initialize(hash)
    @title = hash[:title]
    @year = hash[:year]
    @rank = hash[:rank]
    @url = hash[:url]
    @sample_review = hash[:sample_review]
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  def self.create(hash)
    new_movie = self.new(hash)
    new_movie.save
  end
  
  def self.prepare_movies
    array_of_hashes = Scraper.new.scraped_list_to_array_of_hashes
    array_of_hashes.each do |hash|
      new_movie = self.create(hash)                                   
    end
  end
  
  # def self.prepare_movies
  #   array_of_hashes = Scraper.new.scraped_list_to_array_of_hashes
  #   array_of_hashes.each do |hash|
  #     new_movie = self.create(args)                                   #use #create or #initialize to populate attributes
  #     hash.each do |attribute, data|  
  #       new_movie.send("#{attribute}=", data)
  #     end
  #   end
  # end
  
  def get_extra_info
    unless self.critic_score  
      movie_hash = Scraper.new.scraped_movie_to_hash(self)
      movie_hash.each do |attribute, data|  
        self.send("#{attribute}=", data)
      end
    end
  end
  
end