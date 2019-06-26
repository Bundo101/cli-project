class Movie
  
  attr_accessor :title, :year, :rank
  
  @@all = []
  
  def initialize
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end