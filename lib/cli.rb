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
    puts "\nIf you would like more information on a specific movie please enter that movie's" 
    puts "rank as a number from 1 to 75 (eg for the worst movie type 1 and press enter)."
    puts "\nIf you would like to see a random movie from this list please type \"random\""
    puts "\nIf you would like to view the entire list please type \"all\"" 
    puts "\nTo close the program please type \"exit\""
  end
  
  def more_info?
    puts "\nEnter \"y\" to see a sample review and the aggregate audience and critic"
    puts "scores for this movie or \"n\" to return to the main menu."
  end
  
  def second_level(movie)
    input = gets.chomp
    if input.downcase == "y"
      movie.get_extra_info                   
      puts "#{movie.title}, #{movie.sample_review}"
      
      puts "Audience score: #{movie.user_score}, Critic score: #{movie.critic_score}/100"
    elsif input.downcase == "n"
      main_menu
    else 
      puts "\nInvalid input, please enter \"y\" to see more information"
      puts "about #{movie.title} or \"n\" to return to the main menu."
      second_level(movie)
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
      puts "\nNumber #{found_movie.rank}. #{found_movie.title} was released in cinemas in #{found_movie.year}."     
      more_info?                                                      
      second_level(found_movie)
      main_menu
    elsif raw_input.downcase == "random"
      random_movie = Movie.all.sample                                                                               
      puts "\nNumber #{random_movie.rank}. #{random_movie.title} was released in cinemas in #{random_movie.year}."
      more_info?
      second_level(random_movie)
      main_menu
    elsif raw_input.downcase == "all"
      print_movie_list
      main_menu                                                                
    else
      puts "Please enter valid input"
      main_menu
    end
  end
  
  def print_movie_list
     Movie.all.each { |movie| puts "\n#{movie.rank} #{movie.title}" }   #Need to add and format movie info output here
  end
  
  def create_movies                                                           
    Movie.prepare_movies
  end
  
end