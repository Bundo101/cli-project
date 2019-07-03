# require_relative './scraper.rb'
# require_relative './movie.rb'

class CLI
  
  def welcome
    puts "Greetings discerning movie patron! Welcome to the Hollywood Walk of Shame!"
    puts "\nThe 75 worst motion pictures to ever disappoint an audience and violently" 
    puts "offend critics have been ranked according to the magnitude of their failure."
  end
  
  def prompt_for_input
    puts "\nYou have the following options:"
    puts "\nIf you would like more information on a specific rank please enter that" 
    puts "rank as a number from 1 to 75 (eg for the worst movie type 1 and press enter)."
    puts "\nIf you would like to see a random movie from this list please type \"random\""
    puts "\nIf you would like to view the entire list please type \"all\"" 
    puts "\nTo close the program please type \"exit\""
  end
  
  def get_input
    raw_input = gets.chomp
    input = raw_input.to_i
    if (1..75).include?(input)
      found_movie = Movie.all.detect { |movie| movie.rank == input }
      puts found_movie.title                                          #Need to add and format movie info output here
    elsif raw_input.downcase == "random"
      puts Movie.all.sample.title                                     #Need to add and format movie info output here
    elsif raw_input.downcase == "all"
      Movie.all.each { |movie| puts movie.title }                #Need to add and format movie info output here
    else
      puts "Please enter valid input"
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
    get_input
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