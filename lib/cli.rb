class CLI
  
  def initialize
                 
  end
  
  def start
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
    input = gets.chomp                    
    if input.downcase == "exit"
      exit
    end
    input
  end
 
  def second_level(movie)
    input = gets.chomp
    if input.downcase == "y"
      movie.get_extra_info                   
      puts ("#{movie.title}: ".colorize(:yellow) + "#{movie.plot_summary}").colorize(:background => :blue).bold
      puts ("\nAudience score: #{movie.user_score}, Critic score: #{movie.critic_score}/100").colorize(:green).bold#(:color => :black, :background => :light_white)     
      puts ("\nWhat the critics thought: ".colorize(:yellow) + "#{movie.sample_review}").colorize(:background => :light_red).bold
      #puts "#{String.color_samples}"
      elsif input.downcase == "n"
      main_menu
    else 
      puts "\nInvalid input, please enter \"y\" to see more information"
      puts "about #{movie.title} or \"n\" to return to the main menu."
      second_level(movie)
    end
  end
  
  def main_menu
    input = prompt_for_input
    case 
    when (1..75).include?(input.to_i)  
      found_movie = Movie.find_by_rank(input.to_i)           
      print_basic_movie_data(found_movie)                                              
      second_level(found_movie)
    when input.downcase == "random"
      random_movie = Movie.all.sample                                                                               
      print_basic_movie_data(random_movie)
      second_level(random_movie)
    when input.downcase == "all"
      print_movie_list
    else
      puts "Please enter valid input"
    end
    main_menu
  end
  
  def print_basic_movie_data(movie)
    puts "\nNumber #{movie.rank}. #{movie.title} was released in cinemas in #{movie.year}."
    puts "\nEnter \"y\" to see the plot summary, a sample review and the aggregate"
    puts "audience and critic scores for this movie or \"n\" to return to the main menu."
  end
  
  def print_movie_list
     Movie.all.each { |movie| puts "\n#{movie.rank}. #{movie.title} (#{movie.year})" }   #Need to add and format movie info output here
  end
  
  def create_movies                                                           
    Movie.prepare_movies
  end
  
end