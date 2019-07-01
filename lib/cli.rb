require_relative './scraper.rb'
require_relative './movie.rb'

class CLI
  
  def welcome
    puts "Greetings discerning movie patron! Welcome to the Hollywood Walk of Shame!"
    puts "\nThe 75 worst motion pictures to ever disappoint an audience and violently offend critics have been ranked according to the magnitude of their failure."
    get_input
  end
  
  def get_input
    puts "\nYou have the following options:"
    puts "  If you would like more information on a specific rank please enter that rank as a number (eg for the worst movie enter 1 or for the 20th worst movie enter 20)."
    puts "  Or if you would like to see a random movie from this list please enter \"random\""
    puts "  And finally if you would like to view the entire list please enter \"full\"" 
    input = gets.chomp
    case input 
      when (1..75)
        found_movie = find_movie_by_rank(input.to_i)
        binding.pry
        puts found_movie.title
      end
  end
  
  # def find_movie_by_rank(input)
  #   Movie.all.detect { |movie| movie.rank == input }    #Move this to Movie Class
  # end
  
  def print_movie_list
     Movie.all.each { |movie| puts "#{movie.rank} #{movie.title} - #{movie.year}" }
  end
  
  def initialize
    welcome
    create_movies
  end
  
  def scrape_website
    Scraper.new.scrape_movie_details
  end
  
  def create_movies
    scrape_website.each do |movie_hash|
      new_movie = Movie.new
      movie_hash.each do |attribute, data|  
        new_movie.send("#{attribute}=", data)
      end
    end
  end
  
end