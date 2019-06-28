#require_relative './scraper.rb'

class Movie
  
  attr_accessor :title, :year, :rank, :url, :critic_score, :user_score
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end