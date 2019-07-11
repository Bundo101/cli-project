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
    array_of_hashes = movie_details.map do |movie|
      basic_movie_data = movie.css("h2.slide-title-text").text.split("\"").map(&:strip)      
      if movie.css("div p a").attribute("href").value.include?("www.metacritic.com/")
        url = movie.css("div p a").attribute("href").value                                      #refactor conditional?
      else 
        url = movie.css("div p a")[1].attribute("href").value
      end
      sample_review = movie.text.split("said:")[1].split("\"")[1]
      create_hash(basic_movie_data, url, sample_review)
    end   #returns array of hashes
  end
  
  def scraped_movie_to_hash(movie_object)
    scraped_movie_page = self.scrape_movie_page(movie_object.url)
    if scraped_movie_page.css("div.summary_deck span span span.blurb_expanded").text != ""
      plot_summary = scraped_movie_page.css("div.summary_deck span span span.blurb_expanded").text
    else  
      plot_summary = scraped_movie_page.css("div.summary_deck span span").text                           #refactor conditionals?
    end
    movie_hash = {}
    movie_hash[:critic_score] = scraped_movie_page.css("div.metascore_w.larger:not(.user)").text
    if scraped_movie_page.css("div.metascore_w.user.larger").text != ""
      movie_hash[:user_score] = scraped_movie_page.css("div.metascore_w.user.larger").text
    else
      movie_hash[:user_score] = "tbd"
    end
    movie_hash[:plot_summary] = plot_summary
    movie_hash
  end

end