#require_relative './scraper.rb'

class Movie
  
  attr_accessor :title, :year, :rank, :url
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end