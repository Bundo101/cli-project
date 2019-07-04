# require_relative './scraper.rb'
# require_relative './movie.rb'

class CLI
  
  def initialize
    welcome
    create_movies
    main_menu
  end
  
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
  
  def more_info?
    puts "Would you like to see a sample review and the aggregate audience and critic"
    puts "scores for this movie? Please type \"y\" or \"n\" and hit Enter"
  end
  
  def second_level(movie)
    input = gets.chomp
    if input.downcase == "y"
     #binding.pry
     Scraper.new.scraped_movie_to_hash(movie.url)
    elsif input.downcase == "n"
      main_menu
    else 
      puts "Please enter y or n"
    end
  end
  
  def main_menu
    prompt_for_input
    raw_input = gets.chomp
    input = raw_input.to_i
    if raw_input.downcase == "exit"
      exit
    elsif (1..75).include?(input)
      found_movie = Movie.all.detect { |movie| movie.rank == input }
      puts found_movie.title                                                    #Need to add and format movie info output here
      more_info?                                                      
      second_level(found_movie)
    elsif raw_input.downcase == "random"
      random_movie = Movie.all.sample.title                                     #Need to add and format movie info output here
      puts random_movie
      more_info?
      second_level(random_movie)
    elsif raw_input.downcase == "all"
      print_movie_list
      main_menu                                                                #Need to add pause or smthg 
    else
      puts "Please enter valid input"
    end
  end
  
  def print_movie_list
     Movie.all.each { |movie| puts "#{movie.rank} #{movie.title} - #{movie.year}" }   #Need to add and format movie info output here
  end
  
  def scrape_single_movie
    Scraper.new
  end
  
  def scrape_list_movies
    Scraper.new.scraped_list_to_array_of_hashes
  end
  
  def create_movies
    scrape_list_movies.each do |movie_hash|
      new_movie = Movie.new
      movie_hash.each do |attribute, data|  
        new_movie.send("#{attribute}=", data)
      end
    end
  end
  
end