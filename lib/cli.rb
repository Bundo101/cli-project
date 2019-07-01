require_relative './scraper.rb'
require_relative './movie.rb'

class CLI
  
  def welcome
    puts "Greetings discerning movie patron! Welcome to the Hollywood Walk of Shame!"
    puts "\nThe 75 worst motion pictures to ever disappoint an audience and violently offend critics have been gathered and ranked according to the magnitude of their failure."
  end
  
  def print_movie_list
     Movie.all.each { |movie| puts "#{movie.rank} #{movie.title} - #{movie.year}" }
  end
  
  def initialize
    welcome
    create_movies
    print_movie_list
  end
  
  def scrape_website
    Scraper.new.scrape_movie_details
  end
  
  def create_movies
    scrape_website.each do |movie|
      new_movie = Movie.new
      movie.each do |attribute, data|  
        new_movie.send("#{attribute}=", data)
      end
    end
  end
  
end