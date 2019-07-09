#require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  end
  
  def scrape_movie_page(url)
    doc = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  end
  
  def create_hash
    
  end
  
  def scraped_list_to_array_of_hashes                            
    movie_details = self.scrape_list_page.css("div.slide")
    array_of_hashes = movie_details.map do |movie|
      movie_hash = {}
      basic_movie_data = movie.css("h2.slide-title-text").text.split("\"").map(&:strip)
      movie_hash[:rank] = basic_movie_data[0].delete(".").to_i                                  #abstract out the hash creation
      movie_hash[:title] = basic_movie_data[1]
      movie_hash[:year] = basic_movie_data[2].delete("()")                                      #check if scrape selectors can be improved
      url = movie.css("div p a").attribute("href").value
      movie_hash[:url] = url
      sample_review = movie.text.split("said:")[1].split("—")[0]
      movie_hash[:sample_review] = sample_review
      movie_hash
    end   #returns array of hashes
  end
  
  def scraped_movie_to_hash(movie_object)
    #binding.pry
    scraped_movie_page = self.scrape_movie_page(movie_object.url)
    movie_scores = scraped_movie_page.css("a.metascore_anchor").text
    plot_summary = scraped_movie_page.css("div.summary_deck span span").text                  #check if scrape selectors can be improved
    movie_hash = {}
    movie_score_array = movie_scores.split("   ")
    movie_hash[:critic_score] = movie_score_array[0].gsub("\n","").strip
    if /\d/.match(movie_score_array[2]) 
      movie_hash[:user_score] = "#{movie_score_array[1].gsub("\n", "").strip}/10"
    else
      movie_hash[:user_score] = "TBD"
    end
    movie_hash[:plot_summary] = plot_summary
    movie_hash
  end

end