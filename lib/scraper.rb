#require_relative './movie.rb'

class Scraper
  
  def scrape_list_page
    doc = Nokogiri::HTML(open("https://www.businessinsider.com/worst-movies-all-time-according-to-critics-2017-8?r=US&IR=T"))
  end
  
  def scrape_movie_page(url)
    doc = Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  end
  
  def create_hash(basic_movie_data, url, sample_review)
    movie_hash = {}
    movie_hash[:rank] = basic_movie_data[0].delete(".").to_i                                  
    movie_hash[:title] = basic_movie_data[1]
    movie_hash[:year] = basic_movie_data[2].delete("()")
    movie_hash[:url] = url
    movie_hash[:sample_review] = sample_review
    movie_hash
  end
  
  def scraped_list_to_array_of_hashes                            
    movie_details = self.scrape_list_page.css("div.slide")
    movie_details.map do |movie|
      basic_movie_data = movie.css("h2.slide-title-text").text.split("\"").map(&:strip)      
      
      standard_url = movie.css("div p a").attribute("href").value
      alternate_url = movie.css("div p a")[1].attribute("href").value
      standard_url.include?("www.metacritic.com/") ? url = standard_url : url = alternate_url
        
      sample_review = movie.text.split("said:")[1].split("\"")[1]
      create_hash(basic_movie_data, url, sample_review)
    end   #returns array of hashes
  end
  
  def scraped_movie_to_hash(movie_object)
    scraped_movie_page = self.scrape_movie_page(movie_object.url)
    movie_hash = {}
    
    expanded_summary = scraped_movie_page.css("div.summary_deck span span span.blurb_expanded").text
    basic_summary = scraped_movie_page.css("div.summary_deck span span").text
    expanded_summary != "" ? plot_summary = expanded_summary : plot_summary = basic_summary                                                                   
    
    movie_hash[:critic_score] = scraped_movie_page.css("div.metascore_w.larger:not(.user)").text
    
    user_score = scraped_movie_page.css("div.metascore_w.user.larger").text
    user_score != "" ? movie_hash[:user_score] = "#{user_score}/10" : movie_hash[:user_score] = "tbd"
    
    movie_hash[:plot_summary] = plot_summary
    
    movie_hash
  end

end