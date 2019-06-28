
class Movie
  
  attr_accessor :title, :year, :rank, :url, :critic_score, :user_score, :sample_review
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end