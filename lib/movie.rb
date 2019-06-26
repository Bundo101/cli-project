class Movie
  
  attr_accessor :title, :release_year, :list_position
  
  @@all = []
  
  def initialize(title, year, postion)
    @title = title
    @year = year
    @position = position
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end